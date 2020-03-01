//
//  FlatWrapper.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 3/1/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation


struct Flat {
    var schema = """
    table User {
    name: string;
    }
    root_type user;
    """
    func parser() {
        let p = Wrapper()
        var m: [UInt8] = [1, 2, 3, 4]
        print(p.printJSON(fromBuffer: &m, from: schema))
    }
}
