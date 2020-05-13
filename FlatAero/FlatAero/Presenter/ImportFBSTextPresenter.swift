//
//  ImportFBSTextPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/12/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol TextPresenterDelegate: class {}
protocol TextPresenterControllerDelegate: class {}

class ImportFBSTextPresenter: NSObject, TextPresenterDelegate {
  
  weak var controller: TextPresenterControllerDelegate?
  weak var mainPresenter: MainViewPresenterDelegate?
  
  init(controller: TextPresenterControllerDelegate, mainPresenter: MainViewPresenterDelegate?) {
    self.controller = controller
    self.mainPresenter = mainPresenter
  }
}
