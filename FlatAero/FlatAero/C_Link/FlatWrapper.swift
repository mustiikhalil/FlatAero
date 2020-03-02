//
//  FlatWrapper.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation


struct Flat {
    fileprivate var parser = Wrapper()
    fileprivate var schema: String
    
    init(schema _s: String) { schema = _s }
    
    func parser(_ array: inout [UInt8], type: ParseType = .flat) throws -> String {
        var err: NSError?
        var str = ""
        switch type {
        case .flat:
            str = flat(&array, err: &err)
            
        case .json:
            str = json(&array, err: &err)
        }
        
        if let err = err {
            throw err
        }
        
        return str
    }
    
    func json(_ array: inout [UInt8], err: inout NSError?) -> String {
        return parser.printJSON(fromBuffer: &array, from: schema, error: &err)
    }
    
    func flat(_ array: inout [UInt8], err: inout NSError?) -> String {
        return parser.printFLAT(fromBuffer: &array, from: schema, error: &err)
    }
    
    enum ParseType {
        case json, flat
    }
}
