//
//  ImportFiles.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

protocol ImportFiles {
    func selectedFile(_ url: URL, ofType type: ImportableTypes)
}

extension ImportFiles {

    func importFile(in view: NSView, type: ImportableTypes, fileTypes: [String] = ["fbs"]) {
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedFileTypes = fileTypes
        
        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                guard !panel.urls.isEmpty else { return }
                self.selectedFile(panel.urls[0], ofType: type)
            }
        }
    }
}
