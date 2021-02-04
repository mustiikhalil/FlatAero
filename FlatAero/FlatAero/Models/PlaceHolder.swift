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
    """
}
