//
//  DecodeProtocols.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

protocol DecodeViewPresenterDelegate: Presenter {
    var importedData: ImportedData? { get set }
    var type: Flat.ParseType { get set }
    func decode()
}

protocol DecodeViewControllerDelegate: class {
    func parsedBuffer(_ str: String)
}
