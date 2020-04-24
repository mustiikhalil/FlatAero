//
//  Errors.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

enum Errors: Error, LocalizedError {
    case invalidArrayInput, libraryError(e: Error), schemaRequiresRoot, flatAeroCantHandleImports, couldntOpenFile
    
    var errorDescription: String? {
        switch self {
        case .invalidArrayInput:
            return "The input array is invalid or empty please check it!"
            
        case .schemaRequiresRoot:
            return "Schema is invalid!\n Check if the Schema has root_type"
            
        case .libraryError(let err):
            return err.localizedDescription
            
        case .flatAeroCantHandleImports:
            return "FlatAero cant handle flatbuffers imports yet."
            
        case .couldntOpenFile:
            return "Couldnt open file"
        }
    }
}
