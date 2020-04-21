//
//  MainViewPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class MainViewPresenter: NSObject, MainViewPresenterDelegate {
    
    weak var controller: MainViewControllerPresenterDelegate?
    weak var router: MainViewRouterDelegate?
    
    init(controller: MainViewControllerPresenterDelegate, router: MainViewRouterDelegate) {
        self.controller = controller
        self.router = router
    }
}
