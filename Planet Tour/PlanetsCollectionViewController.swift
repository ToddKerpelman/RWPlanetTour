//
//  PlanetsCollectionViewController.swift
//  Planet Tour
//
//  Created by Todd Kerpelman on 5/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PlanetCell"
private let sectionInsets = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)

class PlanetsCollectionViewController: UICollectionViewController {


  func planetForIndexPath(indexPath: NSIndexPath) -> Planet {
    return SolarSystem.sharedInstance.planetAtNumber(indexPath.row);
  }


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
      cell.backgroundColor = UIColor.blueColor()
      return cell
    }



    // MARK: UICollectionViewDelegate


  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("planetDetailSegue", sender: self)
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let planetDetail = segue.destinationViewController as? PlanetDetailViewController,
      let selectedPlanetNumber = collectionView?.indexPathsForSelectedItems()?[0].row
      else { return }
    print("Selected plaent number if \(selectedPlanetNumber)")
    planetDetail.planet = SolarSystem.sharedInstance.planetAtNumber(selectedPlanetNumber)
  }



  override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
    self.collectionView?.collectionViewLayout.invalidateLayout()
  }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension PlanetsCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let maxHeight = self.view.frame.height - sectionInsets.top - sectionInsets.bottom - 30
    print("Max height is \(maxHeight)")
    let idealCellSize = CGFloat(400)
    let cellSize = min(maxHeight, idealCellSize)
    return CGSize(width: cellSize, height: cellSize)
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return sectionInsets
  }


}


