//
//  ValidateOperation.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 5/18/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class ValidateOperation: AsyncOperation<ImportedData, Error> {
  
  fileprivate var data: ImportedData?
  
  init(data: ImportedData?) {
    self.data = data
    super.init()
  }
  
  override func main() {
    guard let data = data else {
      Logging.logger.warning("Failed to pass data into validate operation")
      finish(with: .failure(Errors.importedDataNotFound))
      return
    }
    guard data.validate else {
      Logging.logger.warning("Decoded pressed without a valid table or buffer")
      finish(with: .failure(Errors.invalidTableOrBuffer))
      return
    }
    finish(with: .success(data))
  }
}
