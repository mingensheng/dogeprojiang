#include "gtest/gtest.h"
#include "../decoder.cpp"
#include <string>
#include "/home/klee/dogeprojiang/lib/testPrimitives.h"


//int testInt(int a, int b);
class testInt0 : public ::testing::Test {
protected:
int return_value = 0;
int a;
int b;
      int size_array[2];
  virtual void SetUp() {
      void **ptrs = new void *[2];
      char **value_array = new char*[2];
      //set up value array
      char* s0= ("00000000");
      value_array[0] = new char[4];
      size_array[0] = 4;
      hex2bin(s0, value_array[0]);
      char* s1= ("00000000");
      value_array[1] = new char[4];
      size_array[1] = 4;
      hex2bin(s1, value_array[1]);
      for(int i=0; i<2; i++){
          ptrs[i] = new char[sizeof(*value_array[i])];
      }
      decoder(2, ptrs, value_array, size_array);
      memcpy(&a, ptrs[0], size_array[0]);
      memcpy(&b, ptrs[1], size_array[1]);
  }
};
TEST_F(testInt0, gtest) {
  EXPECT_EQ(return_value, testInt(a, b));
}


//int testInt(int a, int b);
class testInt1 : public ::testing::Test {
protected:
int return_value = 2147483647;
int a;
int b;
      int size_array[2];
  virtual void SetUp() {
      void **ptrs = new void *[2];
      char **value_array = new char*[2];
      //set up value array
      char* s0= ("00000000");
      value_array[0] = new char[4];
      size_array[0] = 4;
      hex2bin(s0, value_array[0]);
      char* s1= ("ffffff7f");
      value_array[1] = new char[4];
      size_array[1] = 4;
      hex2bin(s1, value_array[1]);
      for(int i=0; i<2; i++){
          ptrs[i] = new char[sizeof(*value_array[i])];
      }
      decoder(2, ptrs, value_array, size_array);
      memcpy(&a, ptrs[0], size_array[0]);
      memcpy(&b, ptrs[1], size_array[1]);
  }
};
TEST_F(testInt1, gtest) {
  EXPECT_EQ(return_value, testInt(a, b));
}





int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
