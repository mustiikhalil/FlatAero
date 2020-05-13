//
//  Logging.swift
//  FlatAero
//
//  Created by Mustafa Khalil on 5/13/20.
//  Copyright © 2020 Mustafa Khalil. All rights reserved.
//

import SwiftyBeaver
import FlatBuffers

struct Logging {
  
  static let logger = SwiftyBeaver.self
  
  static func __init() {
    guard let url = Bundle.main.url(forResource: "keys", withExtension: "mon"),
      let data = try? Data(contentsOf: url) else {
      return
    }
    let keys = LogKeys.getRootAsLogKeys(bb: ByteBuffer(data: data))
    let platform = SBPlatformDestination(appID: keys.appId ?? "",
                                         appSecret: keys.appSecret ?? "",
                                         encryptionKey: keys.encryption ?? "")
    Logging.logger.addDestination(platform)
    Logging.logger.addDestination(ConsoleDestination())
  }
}
