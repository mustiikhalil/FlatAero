//
//  DecodeViewPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class DecodeViewPresenter: NSObject, DecodeViewPresenterDelegate {
  
  var importedData: ImportedData?
  var type: Flat.ParseType = .flat
  
  weak var controller: DecodeViewControllerDelegate?
  weak var parent: MainViewControllerDecodeDelegate?
  
  init(controller: DecodeViewControllerDelegate, parent: MainViewControllerDecodeDelegate) {
    self.controller = controller
    self.parent = parent
  }
  
  func decode() {
    Logging.logger.info("user pressed decode with type: \(type)")
    guard let isValid = parent?.decode(),
      isValid else {
        Logging.logger.warning("Decoded pressed without a valid table or buffer")
        return
    }
    guard let table = importedData?.table, var buffer = importedData?.buffer else { return }
    let flat = Flat(schema: Schema(input: table))
    do {
      let str = try flat.parser(&buffer, type: type)
      controller?.parsedBuffer(str)
    } catch {
      NotificationCenter.default.post(name: .flatAeroError, object: error)
    }
  }
}
