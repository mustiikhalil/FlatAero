//
//  DecoderViewController.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

class DecoderViewController: NSViewController, DecodeViewControllerDelegate {
    
    lazy var decodedLabel: NSLabel = {
        let lbl = NSLabel()
        lbl.stringValue = "Decoded Flatbuffer"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return lbl
    }()
    
    lazy var decodeButton: NSButton = {
        let btn = NSButton(title: "Decode", target: self, action: #selector(decode))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return btn
    }()
    
    lazy var languagePopUpButton: NSPopUpButton = {
        let btn = NSPopUpButton()
        btn.addItems(withTitles: ["JSON"]) //"FLAT",
        return btn
    }()
    
    lazy var decodedTextViewController: TextViewController = {
        let controller = TextViewController()
        controller.isEnabled = false
        return controller
    }()
    
    var presenter: DecodeViewPresenterDelegate!
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func decode() {
        presenter.type = .json
        decodedTextViewController.remove()
        presenter.decode()
    }
    
    func parsedBuffer(_ str: String) {
        decodedTextViewController.add(text: str)
    }
}

extension DecoderViewController {
    
    func setupView() {
        
        let stackView = NSStackView(views: [NSView(), decodeButton])
        
        stackView.spacing = 50
        stackView.distribution = .fill
        view.addSubview(decodedLabel)
        view.addSubview(stackView)
        addChild(decodedTextViewController)
        view.addSubview(decodedTextViewController.view)
        
        stackView.anchorInSuperViewDisregarding(edges: .bottom, padding: .init(top: 4, left: 4, bottom: 4, right: 4))
        
        decodedLabel.anchorInSuperViewDisregarding(edges: .bottom, .top)
        decodedLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        
        decodedTextViewController.view.anchorInSuperViewDisregarding(edges: .top)
        decodedTextViewController.view.topAnchor.constraint(equalTo: decodedLabel.bottomAnchor, constant: 10).isActive = true
    }
}
