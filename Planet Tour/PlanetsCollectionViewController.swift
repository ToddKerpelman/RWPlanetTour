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

private let reuseIdentifier = "PlanetCell"
private let sectionInsets = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)

class PlanetsCollectionViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.backgroundColor = RCValues.sharedInstance.colorForKey(.planetaryBackgroundColor)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    removeWaitingViewController()
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
    cell.imageView.image = currentPlanet.image
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


