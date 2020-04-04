//
//  ImportFromUintArrayController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class ImportFromUintArrayController: NSViewController {
    
    private var padding: NSEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    
    var importTable: NSLabel!
    var pathTextField: NSTextField!
    var importFBSFileButton: FlatAeroButton!
    

    lazy var createArray: NSLabel = {
        let lbl = NSLabel()
        lbl.stringValue = "Copy Paste an UInt8 Array"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return lbl
    }()
    
    lazy var fbsTextViewController: TextViewController = {
        let controller = TextViewController()
        return controller
    }()
    
    lazy var uintArrayViewController: TextViewController = {
        let controller = TextViewController()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension ImportFromUintArrayController: BuildImportFileView {
    
    func importFile(_ sender: Any) {
        
    }
    
    
    func setupView() {
        setupFBSImporterView()
        let stackView = NSStackView(views: [createArray, uintArrayViewController.view])
        stackView.orientation = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        
        view.addSubview(stackView)
        view.addSubview(fbsTextViewController.view)
        stackView.anchorInSuperViewDisregarding(edges: .bottom, padding: padding)
        uintArrayViewController.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        importTable.anchorInSuperViewDisregarding(edges: .top, .bottom, padding: padding)
        importTable.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        
        fbsTextViewController.view.topAnchor.constraint(equalTo: importFBSFileButton.bottomAnchor, constant: 10).isActive = true
        fbsTextViewController.view.anchorInSuperViewDisregarding(edges: .top, padding: padding)
        fbsTextViewController.add(text: PlaceHolder.text)
    }
}
