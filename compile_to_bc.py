#!/usr/bin/python

import os, sys, fnmatch
import shutil
from subprocess import Popen, PIPE

def clean_dir():
  cmd_clean = "make clean"
  process1 = Popen(cmd_clean, shell=True, stdout=PIPE, stderr=PIPE)
  outs1, errs1 = process1.communicate()
  print(outs1.decode("utf-8"))

def compile_driver_with_lib(driver_file):
  print("===================== compiling " + driver_file + "=============================")
  cmd_compile = "make target=" + driver_file
  cmd_link = "make link MAIN=" + driver_file
  process1 = Popen(cmd_compile, shell=True, stdout=PIPE, stderr=PIPE)
  outs1, errs1 = process1.communicate()
  print(outs1.decode("utf-8"))
  print(errs1.decode("utf-8"))
  process2 = Popen(cmd_link, shell=True, stdout=PIPE, stderr=PIPE)
  outs2, errs2 = process2.communicate()
  print(outs2.decode("utf-8"))
  print(errs2.decode("utf-8"))

if __name__ == "__main__":
  driver_files = []

  if not os.path.exists("main_driver_file"):
    print("main driver file doesn't exist")
    sys.exit()
  
  if not os.path.exists ("bcfiles"):
    os.mkdir("bcfiles")
  else:
    shutil.rmtree("bcfiles")
    os.mkdir("bcfiles")

  #remove old bc files
  clean_dir()

  # find all driver files
  for dirpath, dirnames, files in os.walk(os.path.abspath(os.getcwd()+"/main_driver_file")):
    #print(files)
    for filename in fnmatch.filter(files, "*main_driver_file.c"):
      driver_files.append(filename)
      #print(driver_files)
        
    for driver in driver_files:
      driver_name = str.split(driver, '.')[0]
      #print(driver_name)		  	
      compile_driver_with_lib(driver_name)


