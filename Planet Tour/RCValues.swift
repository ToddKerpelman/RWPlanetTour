//
//  RCValues.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/31/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import Firebase

enum ValueKey: String {
  case labelColor
  case planetaryBackgroundColor
  case subscribeBannerText
  case subscribeBannerButton
  case subscribeBannerBGColor
  case subscribeVCText
  case subscribeVCButton
  case shouldWeIncludePluto
  case experimentGroup
}


class RCValues {
  static let sharedInstance = RCValues()

  var loadingDoneCallback: (() -> ())?
  var fetchComplete: Bool = false

  private init() {
    loadDefaultValues()
    fetchCloudValues()
  }

  // MARK: - Initialization steps

  func loadDefaultValues() {
    let appDefaults: [String: NSObject] = [
      ValueKey.labelColor.rawValue: "#FFFFFFFF",
      ValueKey.planetaryBackgroundColor.rawValue: "#000000FF",
      ValueKey.subscribeBannerText.rawValue: "Liking Planet Tour?",
      ValueKey.subscribeBannerButton.rawValue: "Get our newsletter!",
      ValueKey.subscribeBannerBGColor.rawValue: "#999999FF",
      ValueKey.subscribeVCText.rawValue: "Want more astronomy facts? Sign up for our newsletter!",
      ValueKey.subscribeVCButton.rawValue: "Subscribe",
      ValueKey.shouldWeIncludePluto.rawValue: false,
      ValueKey.experimentGroup.rawValue: "default"
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

  // MARK: - Retrieving values

  func boolForKey(key: ValueKey) -> Bool {
    return FIRRemoteConfig.remoteConfig()[key.rawValue].boolValue ?? false
  }

  func stringForKey(key: ValueKey) -> String {
    return FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }

  func colorForKey(key: ValueKey) -> UIColor {
    let colorAsHexString = FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
    let convertedColor = UIColor(rgba: colorAsHexString)
    return convertedColor
  }

}