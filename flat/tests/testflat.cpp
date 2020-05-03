#include <iostream>
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
  auto flat = parser.parse(flatbuffer);
  std::cout << flat << std::endl;
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

void createTestThrowErrorJSON() {
  try {
    flat::JSON parser("");
  } catch (const char *err) {
    std::cerr << "Error named: " << err << std::endl;
  }
}

void createTestThrowErrorFLAT() {
  try {
    flat::FLAT parser("");
  } catch (const char *err) {
    std::cerr << "Error named: " << err << std::endl;
  }
}

void TestThrowErrorMonster(uint8_t* arr) {
  std::string schema_file;
  flatbuffers::LoadFile("../tests/monster.fbs", false, &schema_file);
  testCreatingJSON(schema_file, arr);
  testCreatingFLAT(schema_file, arr);
}

int main(int /*argc*/, const char * /*argv*/[]) {
  createTestUser();
  createTestNumbers();
  createTestThrowErrorJSON();
  createTestThrowErrorFLAT();
  uint8_t arr[] = {80, 0, 0, 0, 77, 79, 78, 83, 72, 0, 132, 0, 8, 0, 0, 0, 6, 0, 40, 0, 0, 0, 44, 0, 0, 0, 4, 0, 48, 0, 52, 0, 56, 0, 0, 0, 60, 0, 0, 0, 0, 0, 5, 0, 64, 0, 68, 0, 96, 0, 104, 0, 72, 0, 76, 0, 112, 0, 120, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 0, 88, 0, 92, 0, 72, 0, 0, 0, 1, 1, 80, 0, 0, 0, 128, 63, 0, 0, 0, 64, 0, 0, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 64, 2, 0, 5, 0, 6, 0, 0, 0, 48, 1, 0, 0, 32, 1, 0, 0, 184, 0, 0, 0, 156, 0, 0, 0, 104, 0, 0, 0, 80, 0, 0, 0, 65, 201, 121, 221, 65, 201, 121, 221, 113, 164, 129, 142, 113, 164, 129, 142, 52, 0, 0, 0, 112, 0, 0, 0, 196, 0, 0, 0, 160, 0, 0, 0, 129, 145, 123, 242, 205, 128, 15, 110, 129, 145, 123, 242, 205, 128, 15, 110, 241, 221, 103, 199, 220, 72, 249, 67, 241, 221, 103, 199, 220, 72, 249, 67, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0, 1, 0, 176, 255, 255, 255, 4, 0, 0, 0, 4, 0, 0, 0, 70, 114, 101, 100, 0, 0, 0, 0, 2, 0, 0, 0, 20, 0, 0, 0, 4, 0, 0, 0, 5, 0, 0, 0, 116, 101, 115, 116, 50, 0, 0, 0, 5, 0, 0, 0, 116, 101, 115, 116, 49, 0, 0, 0, 2, 0, 0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 2, 0, 0, 0, 10, 0, 20, 0, 30, 0, 40, 0, 12, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4, 0, 12, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 70, 114, 101, 100, 0, 0, 0, 0, 3, 0, 0, 0, 255, 255, 255, 255, 255, 255, 239, 255, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 239, 127, 0, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 16, 39, 0, 0, 0, 0, 0, 0, 64, 66, 15, 0, 0, 0, 0, 0, 0, 225, 245, 5, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1, 2, 3, 4, 0, 0, 0, 9, 0, 0, 0, 77, 121, 77, 111, 110, 115, 116, 101, 114, 0, 0, 0};
  TestThrowErrorMonster(arr);
    
  return 0;
}
