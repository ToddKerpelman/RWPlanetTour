//
//  Planet.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

public struct Planet {
  public let name: String
  public let yearInDays: Double
  public let massInEarths: Double
  public let funFact: String
  public let image: UIImage
  public let imageCredit: String

  public init(name: String, yearInDays: Double, massInEarths: Double, funFact: String, imageName: String, imageCredit: String) {
    self.name = name
    self.yearInDays = yearInDays
    self.massInEarths = massInEarths
    self.funFact = funFact
    self.image = UIImage(named: imageName)!
    self.imageCredit = imageCredit
  }


}
