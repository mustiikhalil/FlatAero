//
//  Colors+extenion.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/15/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

extension NSColor {

  convenience init(hex: Int) {
    let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
    let blue = CGFloat(hex & 0xFF) / 255.0
    self.init(calibratedRed: red, green: green, blue: blue, alpha: 1.0)
  }

  static var background: NSColor { NSColor(hex: 0x292a2f) }

  static var codeMainColor: NSColor { NSColor(hex: 0xef82b1) }
}
