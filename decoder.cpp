//argv0: number of arguments; argv1: array of void pointer; argv2: array of byte array
void decoder(int argument_number, void** destination, char** byte_value, int size[]){
  for (int i=0; i<argument_number; i++){
    memcpy(destination[i], byte_value[i], size[i]);
  }
  return;
}

int char2int(char input)
{
  if(input >= '0' && input <= '9')
    return input - '0';
  if(input >= 'A' && input <= 'F')
    return input - 'A' + 10;
  if(input >= 'a' && input <= 'f')
    return input - 'a' + 10;
 // throw std::invalid_argument("Invalid input string");
}

// This function assumes src to be a zero terminated sanitized string with
// an even number of [0-9a-f] characters, and target to be sufficiently large
void hex2bin(char* src, char* target)
{
  while(*src && src[1])
  {
    *(target++) = char2int(*src)*16 + char2int(src[1]);
    src += 2;
  }
}
