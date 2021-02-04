//
//  ChainedAsyncOperation.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 5/18/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol ChainedAsyncOperationOutput {
  var output: Any? { get }
  var error: Error? { get }
}

extension AsyncOperation: ChainedAsyncOperationOutput {

  var output: Any? { try? result?.get() }
  var error: Error? {
    switch result {
    case .failure(let r):
      return r

    default:
      return nil
    }
  }
}

class ChainedAsyncOperation<Input, Success, Failure>: AsyncOperation<
  Success,
  Failure
> where Failure: Error {
  var input: Input?

  init(input: Input? = nil) {
    self.input = input
    super.init()
  }

  override func start() {
    findDependencies()
    guard !isCancelled else { return }
    super.start()
  }

  func findDependencies() {
    guard input == nil && !dependencies.isEmpty else { return }
    let _result = dependencies.compactMap { (operation) -> ChainedAsyncOperationOutput? in
      operation as? ChainedAsyncOperationOutput
    }.first
    input = _result?.output as? Input

    guard input == nil else { return }
    guard let err = _result?.error as? Failure else { return }
    finish(with: .failure(err))
    isCancelled = true
  }
}
