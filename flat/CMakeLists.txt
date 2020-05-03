cmake_minimum_required(VERSION 2.8.12)
set(CMAKE_CXX_STANDARD 17)
# generate compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
include(CheckCXXSymbolExists)

project(FLAT)
option(FLAT_CODE_COVERAGE "Enable the code coverage build option." OFF)
option(FLAT_BUILD_FLATLIB "Enable the build of the flatbuffers library"
       ON)
option(FLAT_BUILD_TESTS "Enable the build of tests and samples." ON)

set(FLATBUFFERS_SRC_DIR flatbuffers)
set(FLAT_Library_SRCS
  src/flat/variables.h
  src/flat/flat.h
  src/flat/flat.cpp
  src/flat/JSON.h
)

set(Flat_Tests_SRCS
  tests/user_generated.h
  tests/numbers_generated.h
  src/flat/flat.cpp
  tests/testflat.cpp
)

if(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Werror -Wextra -Wno-unused-parameter")
  set(FLAT_PRIVATE_CXX_FLAGS "-Wold-style-cast")
endif()

if(FLAT_CODE_COVERAGE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -fprofile-arcs -ftest-coverage")
  set(CMAKE_EXE_LINKER_FLAGS
      "${CMAKE_EXE_LINKER_FLAGS} -fprofile-arcs -ftest-coverage")
endif()

if(FLAT_BUILD_FLATLIB)
    add_library(flat STATIC ${FLAT_Library_SRCS})
    target_include_directories(flat INTERFACE 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>)
    target_compile_options(flat PRIVATE "${FLAT_PRIVATE_CXX_FLAGS}")
endif()

# Add FlatBuffers directly to our build. This defines the `flatbuffers` target.
add_subdirectory(${FLATBUFFERS_SRC_DIR}
                 ${CMAKE_CURRENT_BINARY_DIR}/flatbuffers-build
                 EXCLUDE_FROM_ALL)
# Now simply link against flatbuffers as needed to your already declared target.
# The flatbuffers target carry header search path automatically if CMake > 2.8.11.
target_link_libraries(flat PRIVATE flatbuffers)


if(FLAT_BUILD_TESTS)
  include_directories(${CMAKE_CURRENT_BINARY_DIR}/tests)
  add_executable(tests ${Flat_Tests_SRCS})
  target_link_libraries(tests PRIVATE flat)
  target_link_libraries(tests PRIVATE flatbuffers)
endif()