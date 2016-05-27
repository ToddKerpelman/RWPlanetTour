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

class SolarSystem {
  static let sharedInstance = SolarSystem()

  private var planets: [Planet]!
  private var shouldWeIncludePluto = true

  private init() {
    planets = [
      Planet.init(name: "Mercury", yearInDays: 87.969, massInEarths: 0.3829,
        funFact: "The sun is trying to find a tactful way of telling Mercury it needs some personal space",
        imageName: "Mercury.jpg", imageCredit: "Source: NASA/Johns Hopkins University Applied Physics Laboratory/Carnegie Institution of Washington"),
      Planet.init(name: "Venus", yearInDays: 224.701, massInEarths: 0.815,
        funFact: "Huge fan of saxophone solos in 80s rock songs",
        imageName: "Venus.jpg", imageCredit: "NASA/JPL"),
      Planet.init(name: "Earth", yearInDays: 365.26, massInEarths: 1.0,
        funFact: "Is it getting hot in here, or it is just me?",
        imageName: "Earth.jpg",
        imageCredit: "NASA/JPL"),
      Planet.init(name: "Mars", yearInDays: 686.971, massInEarths: 0.107,
        funFact: "Has selfies with Matt Damon, Arnold Schwarzenegger, The Rock",
        imageName: "Mars.jpg",
        imageCredit: "NASA, ESA, the Hubble Heritage Team (STScI/AURA), J. Bell (ASU), and M. Wolff (Space Science Institute)"),
      Planet.init(name: "Jupiter", yearInDays: 4332.59, massInEarths: 317.8,
        funFact: "Mortified it got a big red spot right before the Senior Planet Prom",
        imageName: "Jupiter.jpg",
        imageCredit: "NASA, ESA, and A. Simon (Goddard Space Flight Center)"),
      Planet.init(name: "Saturn", yearInDays: 10759.22, massInEarths: 95.159 ,
        funFact: "Rings consist of 80% discarded AOL CD-ROMs, 20% packing peanuts",
        imageName: "Saturn.jpg",
        imageCredit: "NASA"),
      Planet.init(name: "Uranus", yearInDays: 30688.5, massInEarths: 14.536,
        funFact: "Seriously, you can stop with the jokes. It's heard them all",
        imageName: "Uranus.jpg",
        imageCredit: "NASA/JPL-Caltech"),
      Planet.init(name: "Neptune", yearInDays: 60182, massInEarths: 17.147,
        funFact: "Claims to be a vegetarian, but eats a cheeseburger at least once a month.",
        imageName: "Neptune.jpg",
        imageCredit: "NASA"),
      Planet.init(name: "Pluto", yearInDays: 90581, massInEarths: 0.002,
        funFact: "Ostracized by friends for spoiling Game of Thrones before got to watch it.",
        imageName: "Pluto.jpg",
        imageCredit: "NASA/JHUAPL/SwRI")

    ]

  }

  func planetCount() -> Int {
    return planets.count
  }

  func planetAtNumber(planetNumber: Int) -> Planet {
    return planets[planetNumber]
  }



}
