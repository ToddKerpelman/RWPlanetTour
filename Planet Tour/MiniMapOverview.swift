//
//  MiniMapOverview.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 6/16/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class MiniMapOverview: UIView {


  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    override func drawRect(rect: CGRect) {
      // This won't be quite accurate, but let's run with it for now.
      let context = UIGraphicsGetCurrentContext()
      CGContextSetLineWidth(context, 4)
      CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0)
      CGContextStrokeRectWithWidth(context, self.bounds, 3.0)
      super.drawRect(rect)
    }

}
