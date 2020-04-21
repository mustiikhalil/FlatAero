//
//  ImportUIntArrayPresenter.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

class ImportUIntArrayPresenter: NSObject, ImportUIntArrayPresenterDelegate {

    var fbsFile: String?
    var binaryData: [UInt8] = []
    
    var data: ImportedData {
        return ImportedData(buffer: binaryData, table: fbsFile)
    }
    
    weak var controller: ImportUIntControllerDelegate?
    
    init(controller: ImportUIntControllerDelegate) {
        self.controller = controller
    }
    
    func set(_ fbs: String) {
        fbsFile = fbs
        controller?.present(fbs: fbs)
    }
}
