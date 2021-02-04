//
//  ImportBinaryPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class ImportBinaryPresenter: NSObject, ImportBinaryPresenterDelegate {

  var fbsFile: String?
  var binaryFile: Data?

  var data: ImportedNSData {
    ImportedNSData(buffer: binaryFile, table: fbsFile)
  }

  weak var controller: ImportBinaryControllerDelegate?

  init(controller: ImportBinaryControllerDelegate) {
    self.controller = controller
  }

  func set(_ fbs: String) {
    fbsFile = fbs
    controller?.present(fbs: fbs)
  }
}
