//
//  WaitingViewController.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/31/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit
import Firebase

class WaitingViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    if RCValues.sharedInstance.fetchComplete {
      startAppForReal()
    }
    RCValues.sharedInstance.loadingDoneCallback = startAppForReal
  }

  func startAppForReal() {
    FIRAnalytics.setUserPropertyString(RCValues.sharedInstance.stringForKey(.subscribeVCButton), forName: "subscribeButtonText")
    self.performSegueWithIdentifier("loadingDoneSegue", sender: self)
  }



}
