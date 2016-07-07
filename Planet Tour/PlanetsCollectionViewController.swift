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
private let sectionInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

class PlanetsCollectionViewController: UICollectionViewController {
  var anotherImage: UIImageView!
  var systemMap: MiniMap!

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.backgroundColor = UIColor(white: 0, alpha: 0.6)
    automaticallyAdjustsScrollViewInsets = false
  }

  func addFancyBackground() {
    if anotherImage != nil { return }
    guard let galaxyImage = UIImage(named: "GalaxyBackground") else { return }
    anotherImage = UIImageView(image: galaxyImage)
    let scaleFactor = view.bounds.height / galaxyImage.size.height
    anotherImage.frame = CGRect(x: 0,
                                y: 0,
                                width: galaxyImage.size.width * scaleFactor,
                                height: galaxyImage.size.height * scaleFactor)
    view.insertSubview(anotherImage, atIndex: 0)
  }

  func addMiniMap() {
    if systemMap != nil { return }
    let miniMapFrame = CGRect(x: view.bounds.width * 0.1, y: view.bounds.height - 80,
                              width: view.bounds.width * 0.8, height: 40)
    systemMap = MiniMap(frame: miniMapFrame)
    view.addSubview(systemMap)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    customizeNavigationBar()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    removeWaitingViewController()
    addFancyBackground()
    addMiniMap()
  }

  func customizeNavigationBar() {
    guard let navBar = navigationController?.navigationBar else { return }
    navBar.barTintColor = RCValues.sharedInstance.colorForKey(.navBarBackground)
    let targetFont = UIFont.init(name: "Avenir-black", size: 18.0) ?? UIFont.systemFontOfSize(18.0)
    navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(),
                                  NSFontAttributeName : targetFont]
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


  func getImageSizeForPlanetNum(planet: Int, withWidth: CGFloat) -> CGFloat {
    let scaleFactor = SolarSystem.sharedInstance.getScaleFactorForPlanet(planet)
    return withWidth * CGFloat(scaleFactor)

  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PlanetCell
    let currentPlanet = SolarSystem.sharedInstance.planetAtNumber(indexPath.row)
    let planetImageSize = getImageSizeForPlanetNum(indexPath.row, withWidth: cell.bounds.width)
    cell.imageView.image = currentPlanet.image
    cell.imageWidth.constant = planetImageSize
    cell.imageHeight.constant = planetImageSize
    cell.nameLabel.text = currentPlanet.name
    cell.nameLabel.textColor = RCValues.sharedInstance.colorForKey(.bigLabelColor)
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
    let backgroundTravel:CGFloat = anotherImage.frame.width -  view.frame.width
    anotherImage.frame.origin = CGPoint(x: -pctThere * backgroundTravel, y: 0)
    systemMap.showPlanet(Int(round(pctThere * CGFloat(SolarSystem.sharedInstance.planetCount()))))
  }
}


extension PlanetsCollectionViewController: UICollectionViewDelegateFlowLayout {

  func biggestSizeThatFits() -> CGFloat {
    let maxHeight = view.frame.height - sectionInsets.top - sectionInsets.bottom - 150
    let idealCellSize = CGFloat(380)
    let cellSize = min(maxHeight, idealCellSize)
    return cellSize
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let cellHeight = biggestSizeThatFits()
    let cellWidth = max(0.5, CGFloat(SolarSystem.sharedInstance.getScaleFactorForPlanet(indexPath.row))) * cellHeight
    return CGSize(width: cellWidth, height: cellHeight)
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

}


