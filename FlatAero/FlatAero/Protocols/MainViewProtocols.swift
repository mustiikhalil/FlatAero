//
//  MainViewProtocols.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol MainViewRouterDelegate: AnyObject {}

protocol MainViewPresenterDelegate: AnyObject {}

protocol MainViewControllerPresenterDelegate: AnyObject {}

protocol MainViewControllerImportsDelegate: AnyObject {}

protocol MainViewControllerDecodeDelegate: AnyObject {
  func fetchData() -> SelectedData
}
