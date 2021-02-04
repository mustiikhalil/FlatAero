//
//  FlatWrapper.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Flat {

  fileprivate var parser = Wrapper()
  fileprivate var schema: Schema

  init(schema _s: Schema) { schema = _s }

  func parser(_ array: inout [UInt8], type: ParseType = .flat) throws -> String {

    guard schema.hasRoot else {
      throw Errors.schemaRequiresRoot
    }

    guard !array.isEmpty else {
      throw Errors.invalidArrayInput
    }

    do {
      try schema.doesntInclude()
    } catch {
      throw error
    }

    var err: NSError?
    var str = ""
    switch type {
    case .flat:
      str = flat(&array, err: &err)

    case .json:
      str = json(&array, err: &err)
    }

    if let err = err {
      throw Errors.libraryError(e: err)
    }

    return str
  }

  func json(_ array: inout [UInt8], err: inout NSError?) -> String {
    parser.printJSON(fromBuffer: &array, from: schema.input, error: &err)
  }

  func flat(_ array: inout [UInt8], err: inout NSError?) -> String {
    parser.printFLAT(fromBuffer: &array, from: schema.input, error: &err)
  }

  enum ParseType: Int {
    case flat, json
  }
}
