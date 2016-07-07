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
 *
 * Note: Thanks to StackOverflow user "Haurus" for the top-aligned CollectionViewFlowLayout
 * code. (See here: http://goo.gl/ISUiD2)
 *
 */


import UIKit

class PlanetaryCollectionViewFlowLayout: UICollectionViewFlowLayout {

  let topSpacing: CGFloat = 80
  let betweenSpacing: CGFloat = 10

  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let superAttributes = super.layoutAttributesForElementsInRect(rect) else { return nil }
    guard let attributesToReturn = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
    for attribute in attributesToReturn {
      if attribute.representedElementKind == nil {
        attribute.frame = layoutAttributesForItemAtIndexPath(attribute.indexPath)!.frame
      }
    }
    return attributesToReturn
  }

  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    guard let superItemAttributes = super.layoutAttributesForItemAtIndexPath(indexPath) else { return nil }
    let currentItemAttributes = superItemAttributes.copy() as! UICollectionViewLayoutAttributes
    let sectionInset = (collectionView?.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
    if indexPath.item == 0 {
      var frame = currentItemAttributes.frame
      frame.origin.y = sectionInset.top + topSpacing
      currentItemAttributes.frame = frame
      return currentItemAttributes
    }
    let previousIndexPath = NSIndexPath.init(forItem: indexPath.item - 1, inSection: indexPath.section)
    guard let previousFrame = layoutAttributesForItemAtIndexPath(previousIndexPath)?.frame else { return nil }
    let previousFrameRightPoint = previousFrame.origin.y + previousFrame.size.height + betweenSpacing
    let previousFrameTop = previousFrame.origin.y
    let currentFrame = currentItemAttributes.frame
    let stretchedCurrentFrame =  CGRect(x: currentFrame.origin.x, y: previousFrameTop, width: currentFrame.size.width, height: collectionView!.frame.size.height)
    if (!CGRectIntersectsRect(previousFrame, stretchedCurrentFrame)) {
      var frame = currentItemAttributes.frame
      frame.origin.y = sectionInset.top + topSpacing
      currentItemAttributes.frame = frame
      return currentItemAttributes
    }
    var frame = currentItemAttributes.frame
    frame.origin.y = previousFrameRightPoint
    currentItemAttributes.frame = frame
    return currentItemAttributes
  }

}