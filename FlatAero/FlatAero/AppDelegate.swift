//
//  AppDelegate.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 2/18/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  
  static let size = NSRect(x: 0, y: 0, width: 1000, height: 500)
  
  var window: NSWindow!
  var mainRouter: MainViewRouter!
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    mainRouter = MainViewRouter()
    mainRouter.start()
    
    window = NSWindow(
      contentRect: AppDelegate.size,
      styleMask: [.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView],
      backing: .buffered, defer: false)
    window.center()
    window.setFrameAutosaveName("Main Window")
    window.contentViewController = mainRouter.navigation
    window.makeFirstResponder(mainRouter.navigation)
    window.makeKeyAndOrderFront(nil)
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  @objc func abort() {
    NSApplication.shared.terminate(self)
  }
}
