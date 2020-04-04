//
//  Styling.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/20/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

protocol Styling {
    
}

extension Styling {
    
    func style(text: String, for textView: NSTextView) {
        
    }
    
    func apply(pattern: String,
               in text: String,
               options: NSRegularExpression.Options = [],
               color: NSColor?,
               textView: NSTextView) {
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return }
        let matches = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
        for match in matches {
            textView.setTextColor(color, range: match.range)
        }
    }
}
