#ifndef JSON_h
#define JSON_h

#include <string>

#include "flatbuffers/idl.h"

namespace flat {
class JSON {
 private:
  flatbuffers::Parser parser;

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
