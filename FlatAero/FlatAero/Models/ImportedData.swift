//
//  ImportedData.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/23/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

struct ImportedData {
    var buffer: [UInt8]?
    var table: String?
    
    var validate: Bool {
        return table != nil && buffer != nil
    }
}
