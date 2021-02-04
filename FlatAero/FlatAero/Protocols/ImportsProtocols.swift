//
//  ImportsProtocols.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

struct SelectedData {
  var decoding: TypesOfDisplayers
  var data: FBSData
}

protocol ImportPresenterDelegate: Presenter {
  func fetchData() -> SelectedData
  func switchDisplayedControllers(of type: Int)
}

protocol ImportControllerDelegate: AnyObject {
  func fetchData() -> SelectedData
  func should(displayController isHidden: Bool)
}

// MARK: - Delegates for containers

protocol ImportUIntControllerDelegate: AnyObject, PresentableFbs {}

protocol ImportUIntArrayPresenterDelegate: Presenter, SetableFbs {
  var data: ImportedArrayData { get }
  var fbsFile: String? { get set }
  var binaryData: [UInt8] { get set }
}

protocol ImportBinaryControllerDelegate: AnyObject, PresentableFbs {}

protocol ImportBinaryPresenterDelegate: Presenter, SetableFbs {
  var data: ImportedNSData { get }
  var fbsFile: String? { get set }
  var binaryFile: Data? { get set }
}

protocol PresentableFbs {
  func present(fbs: String?)
}

protocol SetableFbs {
  func set(_ fbs: String)
}
