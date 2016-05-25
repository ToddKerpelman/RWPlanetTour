//
//  ContainerViewController.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/25/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

  @IBOutlet weak var bannerView: UIView!
  @IBOutlet weak var bannerLabel: UILabel!
  @IBOutlet weak var getNewsletterButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func getNewsletterButtonWasPressed(sender: AnyObject) {
    // No-op right now.
  }

}
