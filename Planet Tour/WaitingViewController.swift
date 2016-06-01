//
//  WaitingViewController.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/31/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.performSegueWithIdentifier("loadingDoneSegue", sender: self)
    }
    // Do any additional setup after loading the view.
  }



}
