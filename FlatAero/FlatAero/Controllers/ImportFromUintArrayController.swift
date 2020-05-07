//
//  ImportFromUintArrayController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class ImportFromUintArrayController: NSViewController, ImportUIntControllerDelegate, TextViewcontrollerDelegate {
    
    private var padding: NSEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
    
    var importTable: NSLabel!
    var pathTextField: NSTextField!
    var importFBSFileButton: FlatAeroButton!
    
    var presenter: ImportUIntArrayPresenterDelegate!
    
    lazy var createArray: NSLabel = {
        let lbl = NSLabel()
        lbl.stringValue = "\(PlaceHolder.exampleArray)"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return lbl
    }()
    
    lazy var fbsTextViewController: TextViewController = {
        let controller = TextViewController()
        controller.textViewType = .fbsFile
        controller.delegate = self
        return controller
    }()
    
    lazy var uintArrayViewController: TextViewController = {
        let controller = TextViewController()
        controller.textViewType = .binary
        controller.delegate = self
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

extension ImportFromUintArrayController: BuildImportFileView, ImportFiles {

    @objc func importFile(_ sender: Any) {
        guard let type = (sender as? FlatAeroButton)?.type, type == .fbsFile else { return }
        importFile(in: view, type: type)
    }
    
    func selectedFile(_ url: URL, ofType type: ImportableTypes) {
        do {
            try openFile(from: url, type: type)
            guard type == .fbsFile else { return }
            pathTextField.stringValue = url.absoluteString
        } catch {
            NotificationCenter.default.post(name: .flatAeroError, object: error)
        }
    }
    
    func set(data: Data) {}
    
    func set(fbs: String) {
        presenter.set(fbs)
    }
    
    func present(fbs: String?) {
        guard let fbs = fbs else { return }
        fbsTextViewController.add(text: fbs)
    }
    
    func textDidChange(in type: ImportableTypes) {
        switch type {
        case .binary:
            var modifiedText = uintArrayViewController.text.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
            modifiedText = modifiedText.replacingOccurrences(of: " ", with: "")
            presenter.binaryData = modifiedText.components(separatedBy: ",").map( { UInt8($0) }).compactMap({ $0 })
            
        case .fbsFile:
            presenter.fbsFile = fbsTextViewController.text
        }
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
        importFBSFileButton.action = #selector(importFile)
    }
}
