//
//  FlatWrapper.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation


struct Flat {
    
    func parser() {
        print("cpp size: ", size())
        parse().map { p in
            print(p.pointee)
        }
    }
}
