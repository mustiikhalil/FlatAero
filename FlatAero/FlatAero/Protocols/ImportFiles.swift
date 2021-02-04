//
//  ImportFiles.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 4/21/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import Cocoa

protocol ImportFiles {
  func set(data: Data)
  func set(fbs: String)
  func selectedFile(_ url: URL, ofType type: ImportableTypes)
}

extension ImportFiles {

  func importFile(
    in view: NSView,
    type: ImportableTypes,
    fileTypes: [String] = ["fbs"])
  {
    guard let window = view.window else { return }

    let panel = NSOpenPanel()
    panel.canChooseFiles = true
    panel.canChooseDirectories = false
    panel.allowsMultipleSelection = false
    panel.allowedFileTypes = fileTypes

    panel.beginSheetModal(for: window) { result in
      if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
        guard !panel.urls.isEmpty else { return }
        self.selectedFile(panel.urls[0], ofType: type)
      }
    }
  }

  func openFile(from url: URL, type: ImportableTypes) throws {
    do {
      let data = try Data(contentsOf: url)
      switch type {
      case .binary:
        set(data: data)

      case .fbsFile:
        let str = try buildStringFrom(data: data)
        set(fbs: str)
      }
    } catch {
      throw error
    }
  }

  func buildStringFrom(data: Data) throws -> String {
    guard let str = String(data: data, encoding: .utf8) else {
      throw Errors.couldntOpenFile
    }
    return str
  }
}
