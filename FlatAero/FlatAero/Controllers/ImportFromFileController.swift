//
//  ImportFromFileController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class ImportFromFileController: NSViewController, ImportBinaryControllerDelegate {
    
    private var padding: NSEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    
    var presenter: ImportBinaryPresenterDelegate!
    
    var importBinaryTable: NSLabel!
    var pathBinaryTextField: NSTextField!
    var importBinaryFileButton: FlatAeroButton!
    
    var importTable: NSLabel!
    var pathTextField: NSTextField!
    var importFBSFileButton: FlatAeroButton!

    lazy var fbsTextViewController: TextViewController = {
        let controller = TextViewController()
        controller.delegate = self
        controller.placeHolderText = PlaceHolder.fbsTable
        controller.textViewType = .fbsFile
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
        case .fbsFile:
            importFile(in: view, type: type)
            
        case .binary:
            importFile(in: view, type: type, fileTypes: ImportableTypes.BinaryFiles)
        }
    }
    
    func selectedFile(_ url: URL, ofType type: ImportableTypes) {
        do {
            try openFile(from: url, type: type)
            switch type {
            case .binary:
                pathBinaryTextField.stringValue = url.absoluteString
                
            case .fbsFile:
                pathTextField.stringValue = url.absoluteString
            }
        } catch {
            NotificationCenter.default.post(name: .flatAeroError, object: error)
        }
    }

    func set(data: Data) {
        print(data.map { $0 })
        presenter.binaryFile = data
    }
    
    func set(fbs: String) {
        presenter.set(fbs)
    }
    
    func present(fbs: String?) {
        guard let fbs = fbs else { return }
        fbsTextViewController.add(text: fbs)
    }
    
}

extension ImportFromFileController: TextViewcontrollerDelegate {
    
    func textDidChange(in type: ImportableTypes) {
        switch type {
        case .binary:
            break
            
        case .fbsFile:
            presenter.fbsFile = fbsTextViewController.text
        }
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
//        fbsTextViewController.add(text: PlaceHolder.)
    }
}
