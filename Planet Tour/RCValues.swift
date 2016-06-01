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

  var loadingDoneCallback: (() -> ())?
  var fetchComplete: Bool = false

  private init() {
    loadDefaultValues()
    fetchCloudValues()
  }

  func loadDefaultValues() {
    let appDefaults: [String: NSObject] = [
      "labelColor" : "#FFFFFFFF"
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
    FIRRemoteConfig.remoteConfig().fetchWithExpirationDuration(fetchDuration) {  [weak self] (status, error) in
       guard let strongSelf = self else { return }
      if error != nil {
        print ("Uh-oh. Got an error fetching remote values \(error)")
      } else {
        print ("Retrieved values from the cloud!")
        FIRRemoteConfig.remoteConfig().activateFetched()
      }
      strongSelf.fetchComplete = true
      strongSelf.loadingDoneCallback?()
    }
  }

  func colorForKey(key: String) -> UIColor {
    let colorAsHexString = FIRRemoteConfig.remoteConfig()[key].stringValue ?? "#FFFFFFFF"
    let convertedColor = UIColor(rgba: colorAsHexString)
    return convertedColor
  }

  


}