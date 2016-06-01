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
    fetchCloudValues()
  }

  func loadDefaultValues() {
    let appDefaults: [String: NSObject] = [
      "label_color" : "#FFFFFFFF"
    ]
    FIRRemoteConfig.remoteConfig().setDefaults(appDefaults)
  }

  func activateDebugMode() {
    let debugSettings = FIRRemoteConfigSettings.init(developerModeEnabled: true)
    FIRRemoteConfig.remoteConfig().configSettings = debugSettings!
  }

  func fetchCloudValues() {
    // Don't do this in production!
    let fetchDuration : NSTimeInterval = 0
    activateDebugMode()
    FIRRemoteConfig.remoteConfig().fetchWithExpirationDuration(fetchDuration) { (status, error) in
      guard error == nil else {
        print ("Uh-oh. Got an error fetching remote values \(error)")
        return
      }
      print ("Retrieved values from the cloud!")
      FIRRemoteConfig.remoteConfig().activateFetched()
    }
  }

  func colorForKey(key: String) -> UIColor {
    let colorAsHexString = FIRRemoteConfig.remoteConfig()["label_color"].stringValue ?? "#FFFFFFFF"
    return UIColor(rgba: colorAsHexString)
  }

  


}