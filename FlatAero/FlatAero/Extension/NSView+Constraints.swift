//
//  NSView+Constraints.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/5/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

extension NSView {
  
  enum Edges {
    case top, bottom, leading, trailing
  }
  
  func fillSuperView(padding: NSEdgeInsets = .init()) {
    translatesAutoresizingMaskIntoConstraints = false
    if let _super = superview {
      NSLayoutConstraint.activate([
        topAnchor.constraint(equalTo: _super.topAnchor, constant: padding.top),
        bottomAnchor.constraint(equalTo: _super.bottomAnchor, constant: -padding.bottom),
        leadingAnchor.constraint(equalTo: _super.leadingAnchor, constant: padding.left),
        trailingAnchor.constraint(equalTo: _super.trailingAnchor, constant: -padding.right)
      ])
    }
  }
  
  func anchorInSuperViewDisregarding(edges: Edges..., padding: NSEdgeInsets = .init()) {
    translatesAutoresizingMaskIntoConstraints = false
    
    if let _super = superview, !edges.contains(.top) {
      topAnchor.constraint(equalTo: _super.topAnchor, constant: padding.top).isActive = true
    }
    if let _super = superview, !edges.contains(.bottom) {
      bottomAnchor.constraint(equalTo: _super.bottomAnchor, constant: -padding.bottom).isActive = true
    }
    if let _super = superview, !edges.contains(.leading) {
      leadingAnchor.constraint(equalTo: _super.leadingAnchor, constant: padding.left).isActive = true
    }
    if let _super = superview, !edges.contains(.trailing) {
      trailingAnchor.constraint(equalTo: _super.trailingAnchor, constant: -padding.right).isActive = true
    }
  }
}
