//
//  PlanetDetailViewController.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/24/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {

  @IBOutlet weak var planetNameLabel: UILabel!
  @IBOutlet weak var planetImage: UIImageView!
  @IBOutlet weak var yearLengthLabel: UILabel!
  @IBOutlet weak var massLabel: UILabel!
  @IBOutlet weak var funFactLabel: UILabel!
  @IBOutlet weak var imageCreditLabel: UILabel!

  var planet: Planet?

  func updateLookForPlanet() {
    guard let planet = self.planet else { return }

    self.planetNameLabel.text = planet.name
    self.planetImage.image = planet.image
    self.yearLengthLabel.text = String(planet.yearInDays)
    self.massLabel.text = String(planet.massInEarths)
    self.funFactLabel.text = planet.funFact
    self.imageCreditLabel.text = planet.imageCredit
  }


    override func viewDidLoad() {
        super.viewDidLoad()
      self.updateLookForPlanet()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
