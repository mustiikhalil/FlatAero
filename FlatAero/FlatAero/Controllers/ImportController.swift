//
//  ImportTextController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/12/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class ImportController: NSViewController {
    
    lazy var displayFromArrayOrBinaryFile: NSSegmentedControl = {
        let control = NSSegmentedControl(labels: TypesOfDisplayers.types, trackingMode: .selectOne, target: self, action: #selector(handleSelection))
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegment = 0
        return control
    }()
    
    lazy var importUIntArrayController = ImportFromUintArrayController()
    lazy var importBinaryFileController = ImportFromFileController()
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(displayFromArrayOrBinaryFile)
        displayFromArrayOrBinaryFile.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
        displayFromArrayOrBinaryFile.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        displayFromArrayOrBinaryFile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(importUIntArrayController.view)
        importUIntArrayController.view.anchorInSuperViewDisregarding(edges: .top)
        importUIntArrayController.view.topAnchor.constraint(equalTo: displayFromArrayOrBinaryFile.bottomAnchor, constant: 20).isActive = true
        importUIntArrayController.view.isHidden = true
        
        view.addSubview(importBinaryFileController.view)
        importBinaryFileController.view.anchorInSuperViewDisregarding(edges: .top)
        importBinaryFileController.view.topAnchor.constraint(equalTo: displayFromArrayOrBinaryFile.bottomAnchor, constant: 20).isActive = true
    }
    
}

extension ImportController {
    
    @objc func handleSelection() {
        guard let selection = TypesOfDisplayers(rawValue: displayFromArrayOrBinaryFile.indexOfSelectedItem) else { return }
        switch selection {
        case .file:
            hideControllersAccordingToSelection(true)
            
        case .array:
            hideControllersAccordingToSelection(false)
        }
    }
    
    private func hideControllersAccordingToSelection(_ isHidden: Bool) {
        importUIntArrayController.view.isHidden = isHidden
        importBinaryFileController.view.isHidden = !isHidden
    }
}
