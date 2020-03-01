//
//  wrapper.cpp
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

#include <stdio.h>
#include "flat/flat.h"

extern "C" const char* parse() {
    return "Hello world from cpp";
}
//
//extern "C" const char* reader(flat::FLAT &flat, void* flatbuffer) {
//    return flat.parse(flatbuffer).c_str();
//}
//
extern "C" int size() {
    return 100;
}
