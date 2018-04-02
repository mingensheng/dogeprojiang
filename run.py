#!/usr/bin/python
import os, sys, fnmatch, re, csv, shutil, string
import shutil
from subprocess import Popen, PIPE


if __name__ == "__main__":
    if not os.path.exists ("error"):
        os.mkdir("error")
    else:
        shutil.rmtree("error")
        os.mkdir("error")

    #command1 = "python invoke.py > /error/invoke_error.log  "
    print("#################################################################################")
    print("##This is capstone project created by Yiling Chen, Mingen Sheng, Chengjie Jiang##")
    print("#################################################################################\n\n")

    command1 = "python klee_driver_file_generate.py"
    process1 = Popen(command1, shell=True, stdout=PIPE, stderr=PIPE)
    outs1, errs1 = process1.communicate()
    rc = process1.returncode
    outs1 = outs1.decode()
    errs1 = errs1.decode()
    name = "error/klee_driver_file_generate_error.log"
    fd = open(name, 'w')
    fd.write("===================================errors=========================================\n\n")
    fd.write(errs1)
    fd.write("===================================outputs=========================================\n\n")
    fd.write(outs1)
    fd.close()
    if rc != 0:
        print("!!!klee_driver_file_generate.py run failed, please check error log at ./error/klee_driver_file_generate_error.log\n")
    else:
        print("!!!klee_driver_file_generate.py finished, move on\n")


    command1 = "python compile_to_bc.py"
    process1 = Popen(command1, shell=True, stdout=PIPE, stderr=PIPE)
    outs1, errs1 = process1.communicate()
    rc = process1.returncode
    outs1 = outs1.decode()
    errs1 = errs1.decode()
    name = "error/compile_to_bc_error.log"
    fd = open(name, 'w')
    fd.write("===================================errors=========================================\n\n")
    fd.write(errs1)
    fd.write("===================================outputs=========================================\n\n")
    fd.write(outs1)
    fd.close()
    if rc != 0:
        print("!!!compile_to_bc.py run failed, please check error log at ./error/compile_to_bc_error.log\n")
    else:
        print("!!!compile_to_bc.py finished, move on\n")

    command1 = "python invoke.py"
    process1 = Popen(command1, shell=True, stdout=PIPE, stderr=PIPE)
    outs1, errs1 = process1.communicate()
    rc = process1.returncode
    outs1 = outs1.decode()
    errs1 = errs1.decode()
    name = "error/invoke_error.log"
    fd = open(name, 'w')
    fd.write("===================================errors=========================================\n\n")
    fd.write(errs1)
    fd.write("===================================outputs=========================================\n\n")
    fd.write(outs1)
    fd.close()
    if rc != 0:
        print("!!!invoke.py run failed, please check error log at ./error/invoke_error.log\n")
    else:
        print("!!!invoke.py finished, move on\n")

    command1 = "python compile_to_gtest.py"
    process1 = Popen(command1, shell=True, stdout=PIPE, stderr=PIPE)
    outs1, errs1 = process1.communicate()
    rc = process1.returncode
    outs1 = outs1.decode()
    errs1 = errs1.decode()
    name = "error/compile_to_gtest_error.log"
    fd = open(name, 'w')
    fd.write("===================================errors=========================================\n\n")
    fd.write(errs1)
    fd.write("===================================outputs=========================================\n\n")
    fd.write(outs1)
    fd.close()
    if rc != 0:
        print("!!!compile_to_gtest.py run failed, please check error log at ./error/compile_to_gtest_error.log\n")
    else:
        print("!!!compile_to_gtest.py finished, check directory ./gtest_exe for all Gtest files\n")