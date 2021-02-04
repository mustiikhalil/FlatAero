//
//  BaseOperation.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 5/18/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

infix operator >>>

public class BaseOperation: Operation {

  fileprivate var lockQueue = DispatchQueue(label: "space.mmk.lock")
  fileprivate var _isExecuting = false
  fileprivate var _isFinished = false
  fileprivate var _isAsynchronous = false
  fileprivate var _isCancelled = false

  public override var isExecuting: Bool {
    get {
      lockQueue.sync { _isExecuting }
    }
    set {
      willChangeValue(forKey: "isExecuting")
      lockQueue.sync {
        _isExecuting = newValue
      }
      didChangeValue(forKey: "isExecuting")
    }
  }

  public override var isFinished: Bool {
    get {
      lockQueue.sync { _isFinished }
    }
    set {
      willChangeValue(forKey: "isFinished")
      lockQueue.sync {
        _isFinished = newValue
      }
      didChangeValue(forKey: "isFinished")
    }
  }
  public override var isAsynchronous: Bool {
    get {
      lockQueue.sync { _isAsynchronous }
    }
    set {
      willChangeValue(forKey: "isAsynchronous")
      lockQueue.sync {
        _isAsynchronous = newValue
      }
      didChangeValue(forKey: "isAsynchronous")
    }
  }

  public override var isCancelled: Bool {
    get {
      lockQueue.sync { _isCancelled }
    }
    set {
      willChangeValue(forKey: "isCancelled")
      lockQueue.sync {
        _isCancelled = newValue
      }
      didChangeValue(forKey: "isCancelled")
    }
  }

  public func executing(_ isExecuting: Bool) {
    self.isExecuting = isExecuting
    isFinished = !isExecuting
  }
}

extension OperationQueue {

  public func cancelAllOperationsWithDependencies() {
    for operation in operations.reversed() {
      operation.cancel()
    }
  }
}

extension Operation {

  /// Adds a dependency for the operation, the lhs would be a dependency to rhs
  /// - Parameters:
  ///   - lhs: Operation
  ///   - rhs: Operation
  public static func >>>(lhs: Operation, rhs: Operation) {
    rhs.addDependency(lhs)
  }
}
