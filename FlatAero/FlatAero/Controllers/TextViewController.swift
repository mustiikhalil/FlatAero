//
//  TextViewController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/12/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class TextViewController: NSViewController, NSTextViewDelegate {
    
    var styler: Styling!
    var highlightedText: String = ""
    
    fileprivate lazy var textStorage = NSTextStorage()
    fileprivate lazy var layoutManager = NSLayoutManager()
    fileprivate lazy var textContainer = NSTextContainer()
    fileprivate lazy var textView: NSTextView = NSTextView(frame: CGRect(), textContainer: textContainer)
    fileprivate lazy var scrollview = NSScrollView()
    
    var isEnabled: Bool = true
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollview)
        // Set `true` to enable horizontal scrolling.
        setupUI(isHorizontalScrollingEnabled: false)
        setupLayout()
        setupTextStack()
    }
    
    func remove() {
        textView.string = ""
        highlightedText = ""
    }
    
    func add(text: String) {
        let att = [NSAttributedString.Key.foregroundColor: NSColor.white, .font: NSFont.systemFont(ofSize: 14)]
        textView.textStorage?.append(NSAttributedString(string: text,
                                                        attributes: att))
    }
    
}

extension TextViewController {
    
    fileprivate func setupTextStack() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    }
    
    fileprivate func setupUI(isHorizontalScrollingEnabled: Bool) {
        textView.delegate = self
        let contentSize = scrollview.contentSize
        textContainer.containerSize = CGSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
        textContainer.widthTracksTextView = true
        
        textView.minSize = CGSize(width: 0, height: 0)
        textView.maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = isHorizontalScrollingEnabled
        textView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        textView.autoresizingMask = [.width]
        textView.isEditable = true
        textView.isSelectable = true
        textView.backgroundColor = .clear
        textView.delegate = self
        textStorage.delegate = self
        
        scrollview.borderType = .noBorder
        scrollview.hasVerticalScroller = true
        scrollview.hasHorizontalScroller = isHorizontalScrollingEnabled
        scrollview.documentView = textView
        scrollview.backgroundColor = .background
    }
    
    fileprivate func setupLayout() {
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.fillSuperView()
    }
    
    func textView(_ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool {
        return isEnabled
    }
}

extension TextViewController: NSTextStorageDelegate {
    
    func textStorage(_ textStorage: NSTextStorage,
                     didProcessEditing editedMask: NSTextStorageEditActions,
                     range editedRange: NSRange,
                     changeInLength delta: Int) {
        //        styler.style(text: textView.string, for: textView)
        //        textView.needsDisplay = true
    }
}
