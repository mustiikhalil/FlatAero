//
//  Schema.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Schema {
    var input: String
    
    var isValid: Bool {
        return input.contains("root_type")
    }
}
