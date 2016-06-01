//
//  RCValues.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/31/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import Firebase

class RCValues {
  static let sharedInstance = RCValues()

  private init() {
    loadDefaultValues()
  }

  func loadDefaultValues() {
    let appDefaults: [String: NSObject] = [
      "label_color" : "#FF8888FF"
    ]
    FIRRemoteConfig.remoteConfig().setDefaults(appDefaults)
  }

  func colorForKey(key: String) -> UIColor {
    let colorAsHexString = FIRRemoteConfig.remoteConfig()["label_color"].stringValue ?? "#FFFFFFFF"
    return UIColor(rgba: colorAsHexString)
  }

  


}