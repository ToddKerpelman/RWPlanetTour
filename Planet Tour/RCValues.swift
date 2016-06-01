//
//  RCValues.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/31/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import Firebase

enum valueKey : String {
  case labelColor
  case planetaryBackgroundColor
  case subscribeBannerText
  case subscribeBannerButton
  case subscribeBannerBGColor
  case subscribeVCText
  case subscribeVCButton
  case shouldWeIncludePluto
}


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
      valueKey.labelColor.rawValue: "#FFFFFFFF",
      valueKey.planetaryBackgroundColor.rawValue: "#000000FF",
      valueKey.subscribeBannerText.rawValue: "Liking Planet Tour?",
      valueKey.subscribeBannerButton.rawValue: "Get our newsletter!",
      valueKey.subscribeBannerBGColor.rawValue: "#999999FF",
      valueKey.subscribeVCText.rawValue: "Want more astronomy facts? Sign up for our newsletter!",
      valueKey.subscribeVCButton.rawValue: "Subscribe",
      valueKey.shouldWeIncludePluto.rawValue: false
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

  func boolForKey(key: valueKey) -> Bool {
    return FIRRemoteConfig.remoteConfig()[key.rawValue].boolValue ?? false
  }

  func stringForKey(key: valueKey) -> String {
    return FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }

  func colorForKey(key: valueKey) -> UIColor {
    let colorAsHexString = FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
    let convertedColor = UIColor(rgba: colorAsHexString)
    return convertedColor
  }

  


}