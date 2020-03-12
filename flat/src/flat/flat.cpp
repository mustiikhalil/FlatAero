#include "flat.h"

#include <string>

flat::FLAT::FLAT(const std::string &table) {
  auto ok = parser.Parse(table.c_str());
  if (!ok) { throw "Couldn't parse schema"; }
};

std::string flat::FLAT::parse(const void *flatbuffer) {
  gen_code = "";
  auto root = GetRoot(flatbuffer);
  GenerateFlat(root, *parser.root_struct_def_);
  return gen_code;
}

flat::JSON::JSON(const std::string &table) {
  auto ok = parser.Parse(table.c_str());
  if (!ok) { throw "Couldn't parse schema"; }
}

std::string flat::JSON::parse(const void *flatbuffer) {
  std::string json;
  flatbuffers::GenerateText(parser, flatbuffer, &json);
  return json;
}
