//
//  CrossfadeSegue.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 6/2/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class CrossfadeSegue: UIStoryboardSegue {
  override func perform() {
    let secondVCView = self.destinationViewController.view
    secondVCView.alpha = 0.0
    self.sourceViewController.navigationController?.pushViewController(self.destinationViewController, animated: false)
    UIView.animateWithDuration(0.4) { 
      secondVCView.alpha = 1.0
    }
  }

}
