//
//  GetNewsletterViewController.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/25/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class GetNewsletterViewController: UIViewController {

  @IBOutlet weak var instructionLabel: UILabel!
  @IBOutlet weak var thankYouLabel: UILabel!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var emailTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.thankYouLabel.hidden = true
  }

  @IBAction func submitButtonWasPressed(sender: AnyObject) {
    // We won't actually submit an email, but we can pretend
    self.submitButton.hidden = true
    self.thankYouLabel.hidden = false
    self.emailTextField.enabled = false
  }

}
