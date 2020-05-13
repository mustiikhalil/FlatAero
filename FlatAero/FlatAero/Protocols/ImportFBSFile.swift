//
//  ImportFBSFile.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

@objc protocol BuildImportFileView: class {
  var importTable: NSLabel! { get set }
  var pathTextField: NSTextField! { get set }
  var importFBSFileButton: FlatAeroButton! { get set }
  func importFile(_ sender: Any)
}

extension BuildImportFileView where Self: NSViewController {
  
  var importTableConstructor: NSLabel {
    let lbl = NSLabel()
    lbl.stringValue = "Import Schema (.fbs)"
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    return lbl
  }
  
  var pathTextFieldConstructor: NSTextField {
    let txtfield = NSTextField()
    txtfield.placeholderString = "Path"
    txtfield.translatesAutoresizingMaskIntoConstraints = false
    txtfield.isEditable = false
    return txtfield
  }
  
  var importFBSFileButtonConstructor: FlatAeroButton {
    let btn = FlatAeroButton(type: .fbsFile, title: "Import", target: self)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
    return btn
  }
  
  func setupFBSImporterView() {
    importTable = importTableConstructor
    pathTextField = pathTextFieldConstructor
    importFBSFileButton = importFBSFileButtonConstructor
    
    let importerViewStack = NSStackView(views: [pathTextField, importFBSFileButton])
    importerViewStack.spacing = 10
    importerViewStack.distribution = .fillProportionally
    
    view.addSubview(importTable)
    view.addSubview(importerViewStack)
    
    importerViewStack.topAnchor.constraint(equalTo: importTable.bottomAnchor, constant: 10).isActive = true
    importerViewStack.anchorInSuperViewDisregarding(edges: .top, .bottom, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
  }
}
