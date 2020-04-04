//
//  MainViewController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    var presenter: MainViewPresenterDelegate?
    
    lazy var importController: ImportController = {
        let controller = ImportController()
        return controller
    }()
    
    lazy var decoderController: DecoderViewController = {
        let controller = DecoderViewController()
        return controller
    }()
    
    override func loadView() {
        self.view = NSView()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = AppDelegate.size
        
        addChild(importController)
        addChild(decoderController)
        view.addSubview(importController.view)
        view.addSubview(decoderController.view)
        importController.view.anchorInSuperViewDisregarding(edges: .trailing, padding: .init(top: 24, left: 8, bottom: 8, right: 8))
        decoderController.view.anchorInSuperViewDisregarding(edges: .leading, padding: .init(top: 24, left: 8, bottom: 8, right: 8))
        decoderController.view.leadingAnchor.constraint(equalTo: importController.view.trailingAnchor, constant: 10).isActive = true
        
        importController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: (AppDelegate.size.width / 2) - 8).isActive = true
        decoderController.view.widthAnchor.constraint(equalTo: importController.view.widthAnchor).isActive = true
    }
    
}

extension MainViewController: MainViewControllerPresenterDelegate {
    
}
