#ifndef JSON_h
#define JSON_h

#include <string>

#include "variables.h"

namespace flat {
class JSON {
 private:
  Parser parser;

 public:
  JSON(const std::string &table);
  std::string parse(const void *flatbuffer);
};
}  // namespace flat

#endif /* JSON_h */
