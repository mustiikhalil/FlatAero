//
//  ImportedData.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/23/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol FBSData {
  var table: String? { get }
  var validate: Bool { get }
}

struct ImportedArrayData: FBSData {
  var buffer: [UInt8]?
  var table: String?

  var validate: Bool {
    table != nil && buffer != nil
  }
}

struct ImportedNSData: FBSData {
  var buffer: Data?
  var table: String?

  var validate: Bool {
    table != nil && buffer != nil
  }
}
