//
//  DecodeViewPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class DecodeViewPresenter: NSObject, DecodeViewPresenterDelegate {
  
  var type: Flat.ParseType = .flat
  
  var operationQueue: OperationQueue = {
    let op = OperationQueue()
    op.name = "space.mmk.decode-queue"
    return op
  }()
  
  weak var controller: DecodeViewControllerDelegate?
  weak var parent: MainViewControllerDecodeDelegate?
  
  init(controller: DecodeViewControllerDelegate, parent: MainViewControllerDecodeDelegate) {
    self.controller = controller
    self.parent = parent
  }
  
  func decode() {
    Logging.logger.info("user pressed decode with type: \(type)")
    let validateOperation = ValidateOperation(data: parent?.fetchData())
    let decodeOperation = DecodeOperation(decoderType: type)
    
    decodeOperation.onResult = { [weak self] result in
      switch result {
      case .success(let str):
        self?.controller?.parsedBuffer(str)
        
      case .failure(let err):
        NotificationCenter.default.post(name: .flatAeroError, object: err)
        
      }
    }
    validateOperation >>> decodeOperation
    operationQueue.addOperations([validateOperation, decodeOperation], waitUntilFinished: false)
  }
}
