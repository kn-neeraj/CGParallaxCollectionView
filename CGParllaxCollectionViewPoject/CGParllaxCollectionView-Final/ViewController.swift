//
//  ViewController.swift
//  CGParllaxCollectionView-Final
//
//  Created by CocoaGarage on 04/06/14.
//  Copyright (c) 2014 CocoaGarage. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Array of images to show.
    var images =  ["01-mallorca.jpg", "02-fishing.jpg", "03-chili.jpg", "04-rice.jpg", "05-sweden.jpg", "06-magicForest.jpg", "07-bird.jpg", "08-iguana.jpg", "09-valley.jpg", "10-parrots.jpg"]
    
    // CollectionView property
    let myCollectionView:UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CGParallaxFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup flowLayout.
        var flowLayout:CGParallaxFlowLayout = self.myCollectionView.collectionViewLayout as CGParallaxFlowLayout
        flowLayout.minimumLineSpacing = 16.0
        flowLayout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16)
        
        // Setup CollectionView
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.view.addSubview(self.myCollectionView)
        self.myCollectionView.registerClass(CGParallaxCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.myCollectionView.backgroundColor = UIColor.whiteColor()
        self.myCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as CGParallaxCollectionViewCell
        var imageName: String = self.images[indexPath.row] as String
        cell.imageView.image = UIImage(named: imageName) as UIImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var imageWidth:CGFloat = 640.0
        var imageHeight:CGFloat = 480.0
        var flowLayout:CGParallaxFlowLayout = self.myCollectionView.collectionViewLayout as CGParallaxFlowLayout
        var cellWidth:CGFloat = CGRectGetWidth(self.myCollectionView.bounds) - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        var cellHeight:CGFloat = floorf(cellWidth/imageWidth * imageHeight) - (2 * flowLayout.maxParallaxOffset)
        return CGSizeMake(cellWidth, cellHeight)
    }
    
    override func viewWillLayoutSubviews()  {
        self.myCollectionView.frame = self.view.bounds
        var size:CGSize = CGSizeMake(self.view.bounds.width, self.view.bounds.height)
    }

}

