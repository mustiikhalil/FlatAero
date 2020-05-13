//
//  ImportPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class ImportPresenter: NSObject, ImportPresenterDelegate {
  
  weak var controller: ImportControllerDelegate?
  weak var parent: MainViewControllerImportsDelegate?
  
  init(importControllerDelegate: ImportControllerDelegate, parent parentDelegate: MainViewControllerImportsDelegate) {
    controller = importControllerDelegate
    parent = parentDelegate
  }
  
  func switchDisplayedControllers(of type: Int) {
    guard let selection = TypesOfDisplayers(rawValue: type) else { return }
    controller?.should(displayController: selection == .file)
  }
  
  func prepareData() -> ImportedData {
    guard let controller = controller else { fatalError("import delegate failed") }
    return controller.fetchData()
  }
}
