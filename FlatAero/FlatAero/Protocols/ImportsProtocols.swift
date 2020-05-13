//
//  ImportsProtocols.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol ImportPresenterDelegate: Presenter {
  func switchDisplayedControllers(of type: Int)
  func prepareData() -> ImportedData
}

protocol ImportControllerDelegate: class {
  func fetchData() -> ImportedData
  func should(displayController isHidden: Bool)
}

// MARK: - Delegates for containers

protocol ImportUIntControllerDelegate: class, PresentableFbs {}

protocol ImportUIntArrayPresenterDelegate: Presenter, SetableFbs {
  var data: ImportedData { get }
  var fbsFile: String? { get set }
  var binaryData: [UInt8] { get set }
}

protocol ImportBinaryControllerDelegate: class, PresentableFbs {}

protocol ImportBinaryPresenterDelegate: Presenter, SetableFbs {
  var fbsFile: String? { get set }
  var binaryFile: Data? { get set }
  var data: ImportedData { get }
}

protocol PresentableFbs {
  func present(fbs: String?)
}

protocol SetableFbs {
  func set(_ fbs: String)
}
