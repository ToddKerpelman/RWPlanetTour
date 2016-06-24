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

private let reuseIdentifier = "PlanetCell"
private let sectionInsets = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)

class PlanetsCollectionViewController: UICollectionViewController {
  var anotherImage: UIImageView!
  var systemMap: MiniMap!

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
  }

  func addFancyBackground() {
    if anotherImage != nil { return }
    guard let galaxyImage = UIImage(named: "GalaxyBackground") else { return }
    anotherImage = UIImageView(image: galaxyImage)
    let scaleFactor = view.bounds.height / galaxyImage.size.height
    anotherImage.frame = CGRect(x: 0, y: 0, width: galaxyImage.size.width * scaleFactor, height: galaxyImage.size.height * scaleFactor)
    self.view.insertSubview(anotherImage, atIndex: 0)

    FIRAnalytics.logEventWithName(kFIREventPostScore, parameters: [kFIRParameterScore: 4200])
  }

  func addMiniMap() {
    if systemMap != nil { return }

    let miniMapFrame = CGRect(x: 40, y: view.bounds.height - 80, width: view.bounds.width - 80, height: 40)
    systemMap = MiniMap(frame: miniMapFrame)
    self.view.addSubview(systemMap)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    removeWaitingViewController()
    addFancyBackground()
    addMiniMap()
  }

  func removeWaitingViewController() {
    guard let stackViewControllers = navigationController?.viewControllers else { return }
    if stackViewControllers[0].isKindOfClass(WaitingViewController) {
      navigationController!.viewControllers.removeAtIndex(0)
    }
  }


  func planetForIndexPath(indexPath: NSIndexPath) -> Planet {
    return SolarSystem.sharedInstance.planetAtNumber(indexPath.row);
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return SolarSystem.sharedInstance.planetCount()
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PlanetCell
    let currentPlanet = SolarSystem.sharedInstance.planetAtNumber(indexPath.row)
    let initialImage = currentPlanet.image
    let scaleFactor = SolarSystem.sharedInstance.getScaleFactorForPlanet(indexPath.row)
    let scaledImage = UIImage.init(CGImage: initialImage.CGImage!, scale: 1.0 / CGFloat(scaleFactor), orientation: initialImage.imageOrientation)
    cell.imageView.image = scaledImage
    cell.nameLabel.text = currentPlanet.name
    cell.nameLabel.textColor = RCValues.sharedInstance.colorForKey(.labelColor)
    cell.backgroundColor = RCValues.sharedInstance.colorForKey(.planetaryBackgroundColor)
    return cell
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("planetDetailSegue", sender: self)
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let planetDetail = segue.destinationViewController as? PlanetDetailViewController,
      let selectedPlanetNumber = collectionView?.indexPathsForSelectedItems()?[0].row
      else { return }
    planetDetail.planet = SolarSystem.sharedInstance.planetAtNumber(selectedPlanetNumber)
  }

  override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
    collectionView?.collectionViewLayout.invalidateLayout()
  }

}

// Parallax scrolling!
extension PlanetsCollectionViewController {

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    let pctThere:CGFloat = scrollView.contentOffset.x / scrollView.contentSize.width
    let backgroundTravel:CGFloat = self.anotherImage.frame.width -  self.view.frame.width
    anotherImage.frame.origin = CGPoint(x: -pctThere * backgroundTravel, y: 0)
    systemMap.showPlanet(Int(round(pctThere * CGFloat(SolarSystem.sharedInstance.planetCount()))))
  }

}


extension PlanetsCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let maxHeight = view.frame.height - sectionInsets.top - sectionInsets.bottom - 30
    let idealCellSize = CGFloat(400)
    let cellSize = min(maxHeight, idealCellSize)
    return CGSize(width: cellSize, height: cellSize)
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

}


