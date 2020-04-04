//
//  main.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/4/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

func addMenu() {
    let myApp: NSApplication = NSApplication.shared
    let mainBundle: Bundle = Bundle.main
    let mainNibFileBaseName: String = mainBundle.infoDictionary!["NSMainNibFile"] as! String
    mainBundle.loadNibNamed(mainNibFileBaseName, owner: myApp, topLevelObjects: nil)
}

let delegate = AppDelegate()

NSApplication.shared.delegate = delegate
addMenu()

NSApplication.shared.run()
