/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import Firebase

enum ValueKey: String {
  case bigLabelColor
  case appPrimaryColor
  case navBarBackground
  case navTintColor
  case detailTitleColor
  case detailInfoColor
  case subscribeBannerText
  case subscribeBannerButton
  case subscribeVCText
  case subscribeVCButton
  case shouldWeIncludePluto
  case experimentGroup
  case planetImageScaleFactor
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
    let appDefaults: [String: Any?] = [
      ValueKey.bigLabelColor.rawValue: "#FFFFFF66",
      ValueKey.appPrimaryColor.rawValue: "#FBB03B",
      ValueKey.navBarBackground.rawValue: "#535E66",
      ValueKey.navTintColor.rawValue: "#FBB03B",
      ValueKey.detailTitleColor.rawValue: "#FFFFFF",
      ValueKey.detailInfoColor.rawValue: "#CCCCCC",
      ValueKey.subscribeBannerText.rawValue: "Like Planet Tour?",
      ValueKey.subscribeBannerButton.rawValue: "Get our newsletter!",
      ValueKey.subscribeVCText.rawValue: "Want more astronomy facts? Sign up for our newsletter!",
      ValueKey.subscribeVCButton.rawValue: "Subscribe",
      ValueKey.shouldWeIncludePluto.rawValue: false,
      ValueKey.experimentGroup.rawValue: "default",
      ValueKey.planetImageScaleFactor.rawValue: 0.33
    ]
    RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
  }

  func fetchCloudValues() {
    // WARNING: Don't actually do this in production!
    let fetchDuration: TimeInterval = 0
    activateDebugMode()
    RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) {
      [weak self] (status, error) in
      
      guard error == nil else {
        print ("Uh-oh. Got an error fetching remote values \(error!)")
        // In a real app, you would probably want to call the loading done callback anyway,
        // and just proceed with the default values. I won't do that here, so we can call attention
        // to the fact that Remote Config isn't loading.
        return
      }
      
      RemoteConfig.remoteConfig().activateFetched()
      print ("Retrieved values from the cloud!")
      self?.fetchComplete = true
      self?.loadingDoneCallback?()
    }
  }
  
  func activateDebugMode() {
    let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
    RemoteConfig.remoteConfig().configSettings = debugSettings!
  }

  func color(forKey key: ValueKey) -> UIColor {
    let colorAsHexString = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
    let convertedColor = UIColor(colorAsHexString)
    return convertedColor
  }
  
  func bool(forKey key: ValueKey) -> Bool {
    return RemoteConfig.remoteConfig()[key.rawValue].boolValue
  }
  
  func string(forKey key: ValueKey) -> String {
    return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }
  
  func double(forKey key: ValueKey) -> Double {
    if let numberValue = RemoteConfig.remoteConfig()[key.rawValue].numberValue {
      return numberValue.doubleValue
    } else {
      return 0.0
    }
  }
}
