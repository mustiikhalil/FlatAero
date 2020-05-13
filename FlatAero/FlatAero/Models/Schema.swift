//
//  Schema.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Schema {
  var input: String
  
  var hasRoot: Bool {
    return input.contains("root_type")
  }
  
  func doesntInclude() throws {
    for line in input.components(separatedBy: "\n") {
      let component = line.components(separatedBy: " ")
      if component.contains("include") && !component.contains("//") {
        throw Errors.flatAeroCantHandleImports
      }
    }
  }
}
