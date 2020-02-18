#include <string>

#include "flat/flat.hpp"
#include "user_generated.h"

void testCreatingJSON(const std::string &schema_file) {
  flatbuffers::FlatBufferBuilder b;
  auto root = CreateUserDirect(b, "M", 25, "m@m.com", true);
  b.Finish(root);
  flat::JSON parser(schema_file);
  auto json = parser.parse(b.GetBufferPointer());
}

int main(int /*argc*/, const char * /*argv*/[]) {
  std::string schema_file;
  flatbuffers::LoadFile("../tests/User.fbs", false, &schema_file);
  testCreatingJSON(schema_file);
  return 0;
}
