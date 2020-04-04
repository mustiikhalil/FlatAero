//
//  ImportFromFileController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class ImportFromFileController: NSViewController {
    
    private var padding: NSEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    
    var importBinaryTable: NSLabel!
    var pathBinaryTextField: NSTextField!
    var importBinaryFileButton: FlatAeroButton!
    
    var importTable: NSLabel!
    var pathTextField: NSTextField!
    var importFBSFileButton: FlatAeroButton!

    lazy var fbsTextViewController = TextViewController()
    
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

extension ImportFromFileController: BuildImportFileView, ImportFiles {
    
    @objc func importFile(_ sender: Any) {
        guard let type = (sender as? FlatAeroButton)?.type else { return }
        switch type {
        case .fbsFile: importFile(in: view, type: type)
        case .binary: importFile(in: view, type: type, fileTypes: ImportableTypes.BinaryFiles)
        }
    }
    
    func selectedFile(_ url: URL, ofType type: ImportableTypes) {
        print(url)
    }

}

extension ImportFromFileController {
    
    func setupView() {
        setupBinaryImportView()
        setupFBSImporterView()
        
        importBinaryTable.anchorInSuperViewDisregarding(edges: .bottom, padding: padding)
        importTable.anchorInSuperViewDisregarding(edges: .top, .bottom, padding: padding)
        importTable.topAnchor.constraint(equalTo: pathBinaryTextField.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(fbsTextViewController.view)
        fbsTextViewController.view.topAnchor.constraint(equalTo: importFBSFileButton.bottomAnchor, constant: 10).isActive = true
        fbsTextViewController.view.anchorInSuperViewDisregarding(edges: .top, padding: padding)
        
        importFBSFileButton.action = #selector(importFile)
        importBinaryFileButton.action = #selector(importFile)
    }
    
    func setupBinaryImportView() {
        
        importBinaryTable = importTableConstructor
        pathBinaryTextField = pathTextFieldConstructor
        importBinaryFileButton = importFBSFileButtonConstructor
        
        importBinaryFileButton.type = .binary
        importBinaryTable.stringValue = "Import binary file"
        
        let importerViewStack = NSStackView(views: [pathBinaryTextField, importBinaryFileButton])
        importerViewStack.spacing = 10
        importerViewStack.distribution = .fillProportionally
        
        view.addSubview(importBinaryTable)
        view.addSubview(importerViewStack)
        
        importerViewStack.topAnchor.constraint(equalTo: importBinaryTable.bottomAnchor, constant: 10).isActive = true
        importerViewStack.anchorInSuperViewDisregarding(edges: .top, .bottom, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        fbsTextViewController.add(text: PlaceHolder.text)
    }
}
