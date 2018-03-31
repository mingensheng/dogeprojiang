#!/usr/bin/python
import os, sys, fnmatch, re, csv, shutil


def find_Write_Out(directory, func, filePattern, output_file, decoder_file):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            #print ("filepath"+filepath)
            with open(filepath) as target_file:
                for file_line in target_file:
                    #find the line of declaration in header file
                    if str(func) in file_line:
                        if file_line.split(func,1)[1][0] == '(':
                        #if 1:
                            #find everything inside the outter brackets as arguments
                            m = re.search(r"\((.*?.*)\)", file_line)
                            if m is not None:
                                #return type
                                return_type = file_line.split(func,1)[0].split(" ", 1)[0];
                                f1 = open(output_file, 'a')
                                f1.write("//"+file_line)
                                f1.close()
                                #seperate arguments
                                arguments = temp = re.split(r',\s*(?![^()]*\))', m.group(1))
                                iterator = 0;
                                arguments_num = len(arguments)


                                for argument in arguments:
                                    variable_name = argument.split(" ").pop()
                                    variable_name = variable_name.replace("*", "")

                                    f1 = open(output_file, 'a')
                                    #complete malloc
                                    #argument = argument[1:]
                                    argument_temp = argument
                                    argument_temp = argument_temp.replace("*", "")
                                    #argument_temp = argument_temp.rsplit(" ", 1)[0]
                                    f1.write(argument_temp + ";" + "\n");

                                    f1.write("klee_make_symbolic(&"+variable_name+", sizeof("+variable_name+"), \""+variable_name+"\");")
                                    f1.write("\n")


                                if "float" not in return_type and "int" not in return_type and "bool" not in return_type:
                                    f1.write("//return type is not supoorted by KLEE tool;\n")
                                else:
                                    f1.write(return_type + " output = " + func + "(")

                                    for argument in arguments:
                                        if len(arguments) is 1:
                                            variable_name = argument.split(" ").pop()
                                            variable_name = variable_name.replace("*", "")
                                            if "*" not in argument:
                                                f1.write(variable_name)
                                            else:
                                                f1.write("& "+variable_name)

                                        else:
                                            if argument is arguments[-1]:
                                                variable_name = argument.split(" ").pop()
                                                variable_name = variable_name.replace("*", "")
                                                if "*" not in argument:
                                                    f1.write(variable_name)
                                                else:
                                                    f1.write("& " + variable_name)
                                            else:
                                                variable_name = argument.split(" ").pop()
                                                variable_name = variable_name.replace("*", "")
                                                if "*" not in argument:
                                                    f1.write(variable_name + ", ")
                                                else:
                                                    f1.write("& " + variable_name + ", ")
                                    f1.write(');\n')
                                    if "float" in return_type:
                                        f1.write("printf(\"output:%f \\n\", output);\n")
                                    elif "int" in return_type:
                                        f1.write("printf(\"output:%d \\n\", output);\n")
                                    elif "bool" in return_type:
                                        f1.write("printf(\"output:%d \\n\", output);\n")
                                    else:
                                        f1.write("//return type is not supoorted by KLEE tool;\n")



                                f1.write("return " + func + "(")
                                f1.close()


                                f1 = open(output_file, 'a')
                                for argument in arguments:
                                    if len(arguments) is 1:
                                        variable_name = argument.split(" ").pop()
                                        variable_name = variable_name.replace("*", "")
                                        if "*" not in argument:
                                            f1.write(variable_name)
                                        else:
                                            f1.write("& "+variable_name)

                                    else:
                                        if argument is arguments[-1]:
                                            variable_name = argument.split(" ").pop()
                                            variable_name = variable_name.replace("*", "")
                                            if "*" not in argument:
                                                f1.write(variable_name)
                                            else:
                                                f1.write("& " + variable_name)
                                        else:
                                            variable_name = argument.split(" ").pop()
                                            variable_name = variable_name.replace("*", "")
                                            if "*" not in argument:
                                                f1.write(variable_name + ", ")
                                            else:
                                                f1.write("& " + variable_name + ", ")
                                f1.write(');\n')
                                f1.write("\n\n")
                                f1.close()
                        else:
                            f1 = open(output_file, 'a')
                            f1.write("//!!!!!!!!!!!!!function:" + func + "is not found" + "\n")
                            f1.close()



    return;


if __name__ == "__main__":
    func_list = open("lib/funcList.txt", "r")
    if not os.path.exists ("main_driver_file"):
        os.mkdir("main_driver_file")
    else:
        shutil.rmtree("main_driver_file")
        os.mkdir("main_driver_file")

    # if not os.path.exists ("main_driver_file/gtest"):
    #     os.mkdir("main_driver_file/gtest")
    # else:
    #     shutil.rmtree("main_driver_file/gtest")
    #     os.mkdir("main_driver_file/gtest")

    decoder_file = os.path.join('main_driver_file/gtest', "gtest_converter.cpp")

    #TODO, func name in func list has to strictly be the same
    for func in func_list:
        func = func.rstrip();
        output_file = os.path.join('main_driver_file', func+"_main_driver_file.c")
        f1 = open(output_file, 'w')
        f1.write('#include <klee/klee.h> \n\n')
        f1.write('int main(int argc, char** argv) { \n\n')
        f1.close()

        find_Write_Out(os.getcwd(), func, "*.h", output_file, decoder_file)

        f1 = open(output_file, 'a')
        f1.write('} \n')
        f1.close()











