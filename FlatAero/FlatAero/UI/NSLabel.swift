//
//  NSLabel.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

open class NSLabel: NSTextField {
    init() {
        super.init(frame: .zero)
        isBezeled = false
        drawsBackground = false
        isEditable = false
        isSelectable = false
        alignment = .left
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
