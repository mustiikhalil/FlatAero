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
    union Favorite { Music, Movie }

    table Music {
        name: string;
    }

    table Movie {
        name: string;
    }

    table User {
        name: string;
        age: uint;
        email: string;
        loggedIn: bool;
        starred: Favorite;
    }

    root_type User;
    """
    func parser() {
        let p = Wrapper()
        var m: [UInt8] = [1, 2, 3, 4]
        var err: NSError?
        let w = p.printJSON(fromBuffer: &m, from: schema, error: &err)
    }
}
