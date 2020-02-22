#include <string>

#include "flat/flat.h"
#include "numbers_generated.h"
#include "user_generated.h"

// ****************************************
// TODO: - requires better test cases
// ****************************************

void testCreatingJSON(const std::string &schema_file, void *flatbuffer) {
  flat::JSON parser(schema_file);
  auto json = parser.parse(flatbuffer);
}

void testCreatingFLAT(const std::string &schema_file, void *flatbuffer) {
  flat::FLAT parser(schema_file);
  auto json = parser.parse(flatbuffer);
  std::cout << json << std::endl;
}

void createTestUser() {
  flatbuffers::FlatBufferBuilder b;
  auto favorite_music = CreateMusicDirect(b, "Pink Floyd");
  auto root = CreateUserDirect(b, "M", 25, "mustii@mmk.one", false,
                               Favorite_Music, favorite_music.Union());
  b.Finish(root);
  auto pointer = b.GetBufferPointer();
  std::string schema_file;

  flatbuffers::LoadFile("../tests/User.fbs", false, &schema_file);
  testCreatingJSON(schema_file, pointer);
  testCreatingFLAT(schema_file, pointer);
}

void createTestNumbers() {
  flatbuffers::FlatBufferBuilder b;
  auto p = Position(8, 9, 10);
  auto r = CreatePIValue(b, b.CreateString("3.14"));
  auto root = CreateNumbers(b, Values_l2, Values_MAX, 1, 1, true, 10, 30, 40,
                            50, 60, 90, 10.8, 11.1, &p, r);
  b.Finish(root);
  auto pointer = b.GetBufferPointer();
  std::string schema_file;

  flatbuffers::LoadFile("../tests/numbers.fbs", false, &schema_file);
  testCreatingJSON(schema_file, pointer);
  testCreatingFLAT(schema_file, pointer);
}

int main(int /*argc*/, const char * /*argv*/[]) {
  createTestUser();
  createTestNumbers();
  return 0;
}
