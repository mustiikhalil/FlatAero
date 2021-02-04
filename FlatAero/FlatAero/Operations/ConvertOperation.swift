//
//  ConvertOperation.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 2/4/21.
//  Copyright © 2021 Mustafa Khalil. All rights reserved.
//

import Foundation

class ConvertOperation: ChainedAsyncOperation<
  ImportedNSData,
  ImportedArrayData,
  Error
> {

  override func main() {
    guard let input = input else {
      finish(with: .failure(Errors.noInputPassedToDecode))
      return
    }

    guard let table = input.table, let buffer = input.buffer else { return }

    finish(
      with: .success(
        .init(buffer: buffer.map { $0 }, table: table)
      )
    )
  }
}
