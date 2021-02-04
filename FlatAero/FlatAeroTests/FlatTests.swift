//
//  FlatTests.swift
//  FlatAeroTests
//
//  Created by Mustafa Khalil on 3/2/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import XCTest
@testable import FlatAero

class FlatTests: XCTestCase {
  let schema = """
  union Favorite { Music, Movie }

  table Music {
      name: string;
  }

  table Movie {
      name: string;
  }

  table User {
      name: string;
      age: uint;
      email: string;
      loggedIn: bool;
      starred: Favorite;
  }

  root_type User;
  """
  var array: [UInt8] = [
    20,
    0,
    0,
    0,
    16,
    0,
    24,
    0,
    8,
    0,
    12,
    0,
    16,
    0,
    0,
    0,
    7,
    0,
    20,
    0,
    16,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    36,
    0,
    0,
    0,
    25,
    0,
    0,
    0,
    8,
    0,
    0,
    0,
    36,
    0,
    0,
    0,
    14,
    0,
    0,
    0,
    109,
    117,
    115,
    116,
    105,
    105,
    64,
    109,
    109,
    107,
    46,
    111,
    110,
    101,
    0,
    0,
    1,
    0,
    0,
    0,
    77,
    0,
    6,
    0,
    8,
    0,
    4,
    0,
    6,
    0,
    0,
    0,
    4,
    0,
    0,
    0,
    10,
    0,
    0,
    0,
    80,
    105,
    110,
    107,
    32,
    70,
    108,
    111,
    121,
    100,
    0,
    0,
  ]
  var flat: Flat!

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    flat = Flat(schema: Schema(input: schema))
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testValidArray() {
    do {
      let c = try flat.parser(&array, type: .flat)
      print(c)
    } catch {
      print(error)
    }
  }
}
