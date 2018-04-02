import os, sys, fnmatch
import shutil
from subprocess import Popen, PIPE

def compile_gtest_with_lib(gtest_file):
  print("===================== compiling " + gtest_file + "=============================")
  cmd_compile = "make gtests MAIN=" + gtest_file
  process1 = Popen(cmd_compile, shell=True, stdout=PIPE, stderr=PIPE)
  outs1, errs1 = process1.communicate()
  print(outs1.decode("utf-8"))
  print(errs1.decode("utf-8"))
  




if __name__ == "__main__":
  gtest_files = []

  if not os.path.exists("gtest"):
    print("gtest source file doesn't exist")
    sys.exit()

  if not os.path.exists ("gtest_exe"):
    os.mkdir("gtest_exe")
  else:
    shutil.rmtree("gtest_exe")
    os.mkdir("gtest_exe")

  # find all driver files
  for dirpath, dirnames, files in os.walk(os.path.abspath(os.getcwd()+"/gtest")):
    for filename in fnmatch.filter(files, "*gtest_unit_tests.cpp"):
      gtest_files.append(filename)

    for gtest in gtest_files:
      gtest_name = str.split(gtest, '.')[0]
      #print(gtest_name)                       
      compile_gtest_with_lib(gtest_name)

