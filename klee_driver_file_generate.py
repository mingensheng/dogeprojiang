#!/usr/bin/python
import os, sys, fnmatch, re


def find_Write_Out(directory, func, filePattern, output_file):
    #print(func)
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as target_file:
                for file_line in target_file:
                    #find the line of declaration in header file
                    if str(func) in file_line:
                        #find everything inside the outter brackets as arguments
                        m = re.search(r"\((.*?.*)\)", file_line)
                        if m is not None:
                            f1 = open(output_file, 'a')
                            f1.write("//"+file_line)
                            f1.close()
                            #seperate arguments
                            arguments = m.group(1).split(",")
                            for argument in arguments:
                                variable_name = argument.split(" ").pop()
                                variable_name = variable_name.replace("*", "")
                                f1 = open(output_file, 'a')
                                #complete malloc
                                #argument = argument[1:]
                                argument_temp = argument
                                argument_temp = argument_temp.replace("*", "")
                                argument_temp = argument_temp.rsplit(" ", 1)[0]
                                f1.write(argument+" = malloc(sizeof ("+argument_temp+"));" + "\n")
                                f1.write("klee_make_symbolic(&"+variable_name+", sizeof("+variable_name+"), \""+variable_name+"\");")
                                f1.write("\n")
                            f1.write(func + "(")
                            f1.close()
                            f1 = open(output_file, 'a')
                            for argument in arguments:
                                if len(arguments) is 1:
                                    variable_name = argument.split(" ").pop()
                                    variable_name = variable_name.replace("*", "")
                                    f1.write(variable_name)
                                else:
                                    if argument is arguments[-1]:
                                        variable_name = argument.split(" ").pop()
                                        variable_name = variable_name.replace("*", "")
                                        f1.write(variable_name)
                                    else:
                                        variable_name = argument.split(" ").pop()
                                        variable_name = variable_name.replace("*", "")
                                        f1.write(variable_name + ", ")
                            f1.write(');\n')
                            f1.write("\n\n")
                            f1.close()
                        else:
                            f1 = open(output_file, 'a')
                            f1.write("//!!!!!!!!!!!!!unction:" + func + "is not found" + "\n")
                            f1.close()



    return;


if __name__ == "__main__":
    func_list = open("/Users/williams/Desktop/ECE496/dogeprojiang/ece496M1testcase/funcList.txt", "r")
    output_file = "output.txt"


    f1 = open(output_file, 'w')
    f1.write('#include <klee/klee.h> \n\n')
    f1.write('int main() { \n\n')
    f1.close()

    for func in func_list:
        func = func.rstrip();
        find_Write_Out(os.getcwd(), func, "*.h", output_file)


    f1 = open(output_file, 'a')
    f1.write('} \n')
    f1.close()





        #
    # s = "alpha.Customer[cus_Y4o9qMEZAugtnW] ..."
    # m = re.search(r"\[([A-Za-z0-9_]+)\]", s)
    # print m.group(1)











