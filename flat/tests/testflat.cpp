#include <iostream>

#include "flat/flat.hpp"
int main(int /*argc*/, const char * /*argv*/[]) {
  std::cout << flat::printer() << std::endl;
  return 0;
}
