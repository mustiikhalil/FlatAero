//
//  MainViewRouter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class MainViewRouter: Router {
    
    var navigation: NSViewController!
    
    init() {}
    
    func start() {
        let controller = MainViewController()
        let presenter = MainViewPresenter(controller: controller, router: self)
        controller.presenter = presenter
        
        navigation = controller
    }
    
}

extension MainViewRouter: MainViewRouterDelegate {
    
}
