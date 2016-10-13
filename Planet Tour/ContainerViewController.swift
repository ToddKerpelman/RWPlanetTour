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

import UIKit
import Firebase

class ContainerViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var bannerView: UIView!
  @IBOutlet weak var bannerLabel: UILabel!
  @IBOutlet weak var getNewsletterButton: UIButton!
  fileprivate let takenSurveyKey = "takenSurvey"

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    updateBanner()
    self.title = NSLocalizedString("Planet Tour", comment: "")
    FIRAnalytics.logEvent(withName: "mainPageLoaded", parameters: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if (!UserDefaults.standard.bool(forKey: takenSurveyKey)) {
      runUserSurvey()
    }
    updateNavigationColors()
  }

}

// MARK: - FilePrivate
fileprivate extension ContainerViewController {

  func runUserSurvey() {
    let alertView = UIAlertController(title: "User survey", message: "How do you feel about small, remote, cold rocks in space?", preferredStyle: .actionSheet)
    let fanOfPluto = UIAlertAction(title: "They're planets, too!", style: .default) { (action) in
      FIRAnalytics.setUserPropertyString("true", forName: "likesSmallRocks")
    }
    let notAFan = UIAlertAction(title: "Not worth my time", style: .default) { (action) in
      FIRAnalytics.setUserPropertyString("false", forName: "likesSmallRocks")
    }
    alertView.addAction(fanOfPluto)
    alertView.addAction(notAFan)
    navigationController?.present(alertView, animated: true, completion: nil)
    UserDefaults.standard.set(true, forKey: takenSurveyKey)
  }


  func updateNavigationColors() {
    navigationController?.navigationBar.tintColor = RCValues.sharedInstance.color(forKey: .navTintColor)
  }
  
  func updateBanner() {
    bannerView.backgroundColor = RCValues.sharedInstance.color(forKey: .appPrimaryColor)
    bannerLabel.text = RCValues.sharedInstance.string(forKey: .subscribeBannerText)
    getNewsletterButton.setTitle(RCValues.sharedInstance.string(forKey: .subscribeBannerButton), for: .normal)
  }
}

// MARK: - IBActions
extension ContainerViewController {

  @IBAction func getNewsletterButtonWasPressed(_ sender: AnyObject) {
    // No-op right now.
  }
}
