#ifndef JSON_h
#define JSON_h

#include <string>

#include "variables.h"

namespace flat {
class JSON {
 private:
  Parser parser;

 public:
  JSON(const std::string &table) { parser.Parse(table.c_str()); }

  std::string parse(const void *flatbuffer) {
    std::string json;
    flatbuffers::GenerateText(parser, flatbuffer, &json);
    return json;
  }
};
}  // namespace flat

#endif /* JSON_h */
