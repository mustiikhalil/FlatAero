//
//  PlaceHolder.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Foundation

struct PlaceHolder {
    static let fbsTable =
    """
    union Favorite { Music, Movie }

    table Music {
        name: string;
    }

    table Movie {
        name: string ;
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
    
    static let exampleArray =
    """
    Enter an Array without brackets separating each Uint by a comma
    27, 0, 0, 0, 87, 101, 32, 60, 51, 32, 70, 108, 97, 116, 98, 117,
    102, 102, 101, 114, 115, 33, 32, 70, 108, 97, 116, 65, 101, 114, 111, 0
    """
}
