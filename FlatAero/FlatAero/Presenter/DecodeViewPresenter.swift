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

  init(
    controller: DecodeViewControllerDelegate,
    parent: MainViewControllerDecodeDelegate)
  {
    self.controller = controller
    self.parent = parent
  }

  func decode() {
    Logging.logger.info("user pressed decode with type: \(type)")
    guard let data = parent?.fetchData() else { return }

    let decodeOperation = DecodeOperation(decoderType: type)
    var ops: [Operation] = [decodeOperation]

    switch data.decoding {
    case .array:
      let validateOperation = ValidateOperation(data: data.data as? ImportedArrayData)
      validateOperation >>> decodeOperation
      ops.append(validateOperation)

    case .file:
      let validateOperation = ValidateOperation(data: data.data as? ImportedNSData)
      let converterOperation = ConvertOperation()
      validateOperation >>> converterOperation
      converterOperation >>> decodeOperation
      ops.append(validateOperation)
      ops.append(converterOperation)
    }

    decodeOperation.onResult = { [weak self] result in
      switch result {
      case .success(let str):
        self?.controller?.parsedBuffer(str)

      case .failure(let err):
        NotificationCenter.default.post(name: .flatAeroError, object: err)

      }
    }
    operationQueue.addOperations(ops, waitUntilFinished: false)
  }
}
