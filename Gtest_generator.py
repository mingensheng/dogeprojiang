#!/usr/bin/python
import os, sys, fnmatch, re, csv, shutil, string


def find_Write_Out(directory, func, filePattern, IOfiles_directory, decoder_file):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath, encoding='utf-8') as target_file:
                for file_line in target_file:
                    #find the line of declaration in header file
                    if str(func) in file_line:
                        if file_line.split(func,1)[1][0] == '(':
                            #find the io pairs file in underIOfiles directory
                            #find arguments lenth:
                            m = re.search(r"\((.*?.*)\)", file_line)
                            arguments_num = 0
                            if m is not None:
                                arguments_num = len(re.split(r',\s*(?![^()]*\))', m.group(1)))

                            ioFile_name = os.path.join(func + "_main_driver_file.txt")
                            for io_path, io_dirs, io_files in os.walk(os.path.abspath(IOfiles_directory)):
                                for io_filename in fnmatch.filter(io_files, ioFile_name):
                                    f1 = open(decoder_file, 'a')
                                    f1.write('#include \"' + filepath + '\"\n\n\n')
                                    f1.close()
                                    io_filepath = os.path.join(io_path, io_filename)
                                    with open(io_filepath, encoding='utf-8') as f:
                                        #first_line = f.readline().strip()
                                        lines = f.readlines()
                                        first_line = lines[0].strip()

                                        for itr in range(int(first_line)):
                                            #find everything inside the outter brackets as arguments
                                            m = re.search(r"\((.*?.*)\)", file_line)
                                            if m is not None:
                                                #seperate arguments
                                                arguments = re.split(r',\s*(?![^()]*\))', m.group(1))
                                                iterator = 0;
                                                arguments_num = len(arguments)

                                                f1 = open(decoder_file, 'a')
                                                f1.write("//" + file_line)
                                                f1.write("class " + func + str(itr) + " : public ::testing::Test {\n")
                                                f1.write("protected:\n")
                                                f1.write("int return_value = " + lines[1 + itr * (arguments_num + 1) + arguments_num].strip().split(":").pop() + ";\n")
                                                for argument in arguments:
                                                    variable_name = argument.split(" ").pop()
                                                    variable_name = variable_name.replace("*", "")
                                                    argument_temp = argument
                                                    argument_temp = argument_temp.replace("*", "")
                                                    argument_name = argument_temp.rsplit(" ", 1)[1]
                                                    f1.write(argument_temp + ";\n")
                                                    iterator = iterator + 1
                                                f1.write("      int size_array[" + str(arguments_num) + "];\n")
                                                f1.write("  virtual void SetUp() {\n")
                                                f1.write("      void **ptrs = new void *[" + str(arguments_num) + "];\n")
                                                f1.write("      char **value_array = new char*["+str(arguments_num)+"];\n")
                                                f1.write("      //set up value array\n")
                                                for _itr in range(arguments_num):
                                                    f1.write("      char* s"+ str(_itr) +"= (\""+lines[1+itr*(arguments_num+1)+_itr].strip()+"\");\n")
                                                    hex_s = lines[1+itr*(arguments_num+1)+_itr].strip()
                                                    # print("hex_s: "+hex_s)
                                                    #print("is it true %r" % all(c in string.hexdigits for c in hex_s))
                                                    if (all(c in string.hexdigits for c in hex_s)) is True and len(hex_s) >= 2:
                                                        hex_len = bytearray.fromhex(lines[1 + itr * (arguments_num+1) + _itr].strip()).__len__()
                                                        f1.write("      value_array[" + str(_itr) + "] = new char[" + str(hex_len) + "];\n")
                                                        f1.write("      size_array["+str(_itr)+"] = "+str(hex_len)+";\n")
                                                        f1.write("      hex2bin(s" + str(_itr) + ", value_array[" + str(_itr) + "]"");\n")
                                                    else:
                                                        f1.write("      "+arguments[_itr]+" = \'"+hex_s+"\';\n")

                                                f1 = open(decoder_file, 'a')
                                                f1.write("      for(int i=0; i<"+str(arguments_num)+"; i++){\n")
                                                f1.write("          ptrs[i] = new char[sizeof(*value_array[i])];\n")
                                                f1.write("      }\n")
                                                f1.write("      decoder("+str(arguments_num)+", ptrs, value_array, size_array);" + "\n")
                                                iterator = 0;
                                                function_call_string = str(func+"(")
                                                for argument in arguments:
                                                    variable_type = argument.split(" ")[0]
                                                    if 'char' not in variable_type:
                                                        variable_name = argument.split(" ").pop()
                                                        variable_name = variable_name.replace("*", "")
                                                        f1.write("      memcpy(&"+variable_name+", ptrs["+str(iterator)+"], size_array["+str(iterator)+"]);\n")
                                                        iterator = iterator + 1
                                                        if argument == arguments[-1]:
                                                            function_call_string+=(variable_name+")")
                                                        else:
                                                            function_call_string += (variable_name.replace("[]", "") + ", ")
                                                f1.write("  }\n")
                                                f1.write("};\n")
                                                f1.write("TEST_F("+func+str(itr)+", gtest) {\n")
                                                f1.write("  EXPECT_EQ(return_value, "+function_call_string+");\n}\n\n\n")
                                            f1.close()

    return;


if __name__ == "__main__":
    func_list = open("lib/funcList.txt", "r")

    if not os.path.exists ("gtest"):
        os.mkdir("gtest")
    else:
        shutil.rmtree("gtest")
        os.mkdir("gtest")

    decoder_file = os.path.join('gtest', "gtest_unit_tests.cpp")
    f2 = open(decoder_file, 'w')
    f2.write("#include \"gtest/gtest.h\"\n")
    f2.write("#include \"../decoder.cpp\"\n")
    f2.write("#include <string>\n")
    f2.close()
    IOfiles_directory = os.path.join('IOfiles')

    for func in func_list:
        func = func.rstrip();
        output_file = os.path.join('main_driver_file', func+"_main_driver_file.c")
        find_Write_Out(os.getcwd(), func, "*.h", IOfiles_directory, decoder_file)


    f2 = open(decoder_file, 'a')
    f2.write("\n\n\nint main(int argc, char **argv) {\n")
    f2.write("  ::testing::InitGoogleTest(&argc, argv);\n")
    f2.write("  return RUN_ALL_TESTS();\n}\n")
    f2.close()
