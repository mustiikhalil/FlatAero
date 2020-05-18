//
//  DecodeOperation.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 5/18/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class DecodeOperation: ChainedAsyncOperation<ImportedData, String, Error> {
  
  fileprivate var type: Flat.ParseType
  
  init(decoderType type: Flat.ParseType) {
    self.type = type
    super.init()
  }
  
  override func main() {
    guard let input = input else {
      finish(with: .failure(Errors.noInputPassedToDecode))
      return
    }
    guard let table = input.table, var buffer = input.buffer else { return }
    let flat = Flat(schema: Schema(input: table))
    do {
      let str = try flat.parser(&buffer, type: type)
      DispatchQueue.main.async { [weak self] in
        self?.finish(with: .success(str))
      }
    } catch {
      finish(with: .failure(error))
    }
  }
}
