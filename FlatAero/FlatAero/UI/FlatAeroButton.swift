//
//  FlatAeroButton.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class FlatAeroButton: NSButton {

  var type: ImportableTypes

  init(type: ImportableTypes, title: String, target: Any) {
    self.type = type
    super.init(frame: .zero)
    bezelStyle = .rounded
    self.title = title
    self.target = target as AnyObject
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
