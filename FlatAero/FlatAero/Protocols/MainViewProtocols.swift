//
//  MainViewProtocols.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol MainViewRouterDelegate: class {}

protocol MainViewPresenterDelegate: class {}

protocol MainViewControllerPresenterDelegate: class {}

protocol MainViewControllerImportsDelegate: class {}

protocol MainViewControllerDecodeDelegate: class {
  func fetchData() -> ImportedData
}
