//
//  SolarSystem.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class SolarSystem {
  static let sharedInstance = SolarSystem()

  private var planets: [Planet]!

  private init() {
    planets = [
      Planet.init(name: "Mercury", yearInDays: 42, massInEarths: 4,
        funFact: "Loves long walks",
        imageName: "Mercury.jpg", imageCredit: "Source: NASA/Johns Hopkins University Applied Physics Laboratory/Carnegie Institution of Washington"),
      Planet.init(name: "Venus", yearInDays: 42, massInEarths: 44,
        funFact: "Actually a dude",
        imageName: "Venus.jpg", imageCredit: "NASA/JPL"),
      Planet.init(name: "Earth", yearInDays: 365, massInEarths: 1,
        funFact: "Is it getting hot in here?",
        imageName: "Earth.jpg",
        imageCredit: "NASA/JPL")
    ]

  }

  func planetCount() -> Int {
    return planets.count
  }

  func planetAtNumber(planetNumber: Int) -> Planet {
    return planets[planetNumber]
  }



}
