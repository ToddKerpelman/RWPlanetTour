//
//  MiniMap.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 6/15/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class MiniMap: UIView {

  var mapImage: UIImageView!
  var overviewImage: UIImageView!
  var frameRects: [CGRect]!
  let originalFrameBasis: CGFloat = 600;

  var oldPlanet: Int = -1

  override init(frame: CGRect) {
    super.init(frame: frame)
    frameRects = [
      CGRect(x: 21, y: 48, width: 27, height: 31),
      CGRect(x: 53, y: 47, width: 30, height: 30),
      CGRect(x: 97, y: 47, width: 30, height: 30),
      CGRect(x: 142, y: 52, width: 20, height: 20),
      CGRect(x: 174, y: 11, width: 105, height: 102),
      CGRect(x: 283, y: 5, width: 160, height: 107),
      CGRect(x: 427, y: 39, width: 45, height: 49),
      CGRect(x: 484, y: 40, width: 46, height: 46),
      CGRect(x: 547, y: 53, width: 17, height: 17)

    ]
    createMapImage()
    createOverviewImage()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func createMapImage() {
    mapImage = UIImageView(image: UIImage(named: "SolarSystem"))
    mapImage.contentMode = UIViewContentMode.ScaleAspectFit
    addSubview(mapImage)
  }

  func createOverviewImage() {
    overviewImage = UIImageView(image: UIImage(named: "PlanetFrame")?.resizableImageWithCapInsets(UIEdgeInsets(top: 5.0,left: 5.0,bottom: 5.0,right: 5.0)))
//    overviewImage = MiniMapOverview(frame: CGRect(x: 0, y: 0, width: self.bounds.height, height: self.bounds.height))
    addSubview(overviewImage)
    showPlanet(0)
  }


  func showPlanet(planetNum: Int) {
    if planetNum != oldPlanet {
      oldPlanet = planetNum
      let normalRect = frameRects[planetNum]
      let multiplier = mapImage.bounds.width / originalFrameBasis
      let destinationRect = CGRect(x: normalRect.origin.x * multiplier, y: normalRect.origin.y * multiplier, width: normalRect.width * multiplier, height: normalRect.height * multiplier)
      UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
        self.overviewImage.frame = destinationRect
        }, completion: nil)


    }

  }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
