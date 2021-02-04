//
//  AsyncOperation.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 5/18/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class AsyncOperation<Success, Failure>: BaseOperation where Failure: Error  {

  typealias OperationResult = Result<Success, Failure>

  private(set) var result: OperationResult? {
    didSet {
      guard let result = result else { return }
      onResult?(result)
    }
  }

  var onResult: ((OperationResult) -> Void)?

  override init() {
    super.init()
    isAsynchronous = true
  }

  override func start() {
    guard !isCancelled else { return }
    executing(true)
    main()
  }

  func finish(with operationResult: OperationResult) {
    result = operationResult
    executing(false)
  }

  func cancel(with err: Failure) {
    result = .failure(err)
    executing(false)
  }
}
