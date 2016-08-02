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


class PlanetDetailViewController: UIViewController {

  @IBOutlet weak var planetNameLabel: UILabel!
  @IBOutlet weak var planetImage: UIImageView!
  @IBOutlet weak var yearLengthLabel: UILabel!
  @IBOutlet weak var massTitle: UILabel!
  @IBOutlet weak var yearTitle: UILabel!
  @IBOutlet weak var funFactTitle: UILabel!
  @IBOutlet weak var massLabel: UILabel!
  @IBOutlet weak var funFactLabel: UILabel!
  @IBOutlet weak var imageCreditLabel: UILabel!

  var planet: Planet?

  override func viewDidLoad() {
    super.viewDidLoad()
    updateLabelColors()
    updateLookForPlanet()
    if let planet = self.planet {
      FIRAnalytics.logEvent(withName: "visited_planet_details", parameters: ["planet": planet.name])
    }
  }

  func updateLabelColors() {
    let titlesToRecolor: [UILabel] = [yearTitle, massTitle, funFactTitle]
    for nextLabel in titlesToRecolor {
      nextLabel.textColor = RCValues.sharedInstance.colorForKey(.appPrimaryColor)
    }
    let labelsToRecolor: [UILabel] = [yearLengthLabel, massLabel, funFactLabel]
    for nextLabel in labelsToRecolor {
      nextLabel.textColor = RCValues.sharedInstance.colorForKey(.detailInfoColor)
    }
    planetNameLabel.textColor = RCValues.sharedInstance.colorForKey(.detailTitleColor)
  }

  func updateLookForPlanet() {
    guard let planet = self.planet else { return }
    planetNameLabel.text = planet.name
    planetImage.image = planet.image
    yearLengthLabel.text = String(planet.yearInDays)
    massLabel.text = String(planet.massInEarths)
    funFactLabel.text = planet.funFact
    imageCreditLabel.text = "Image credit: \(planet.imageCredit)"
  }

}
