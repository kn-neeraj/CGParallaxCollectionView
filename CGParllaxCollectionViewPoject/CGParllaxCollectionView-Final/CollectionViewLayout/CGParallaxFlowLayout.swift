//
//  CGParallaxFlowLayout.swift
//  CGParllaxCollectionView-Final
//
//  Created by CocoaGarage on 04/06/14.
//  Copyright (c) 2014 CocoaGarage. All rights reserved.
//

import Foundation
import UIKit

class CGParallaxFlowLayout: UICollectionViewFlowLayout {
    
    let maxParallaxOffset : CGFloat = 30.0 // A constant
    
    // Overriden Methods
    override class func layoutAttributesClass() -> AnyClass! {
        return CGParallaxLayoutAttributes.self
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> AnyObject[]! {
        var layoutAttrArr : Array<AnyObject> = super.layoutAttributesForElementsInRect(rect)
        for layoutAttr : AnyObject in layoutAttrArr {
            if layoutAttr.isKindOfClass(CGParallaxLayoutAttributes.self) {
                var paralaxLayoutAttr: CGParallaxLayoutAttributes = layoutAttr as CGParallaxLayoutAttributes
                if paralaxLayoutAttr.representedElementCategory == UICollectionElementCategory.Cell {
                    paralaxLayoutAttr.parallaxOffset = self.parallaxOffsetForLayoutAttribtues(paralaxLayoutAttr)
                }
            }
        }
        return layoutAttrArr
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes! {
        var layoutAttributes : CGParallaxLayoutAttributes = super.layoutAttributesForItemAtIndexPath(indexPath) as CGParallaxLayoutAttributes
        
        layoutAttributes.parallaxOffset = self.parallaxOffsetForLayoutAttribtues(layoutAttributes)
        return layoutAttributes
    }
    
    func parallaxOffsetForLayoutAttribtues(layoutAttributes: CGParallaxLayoutAttributes) -> CGPoint {
        
        if layoutAttributes == nil {
            return CGPointZero
        }
        if (!layoutAttributes.isKindOfClass(CGParallaxLayoutAttributes.self)) {
            return CGPointZero
        }
        
        var bounds: CGRect = self.collectionView.bounds
        var boundsCenter : CGPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        var cellCenter : CGPoint = layoutAttributes.center
        var offsetFromCenter : CGPoint = CGPointMake(boundsCenter.x - cellCenter.x, boundsCenter.y - cellCenter.y)
        var cellSize: CGSize  = layoutAttributes.size
        
        var maxVerticalOffsetVisible: CGFloat = bounds.size.height/2 + cellSize.height/2
        var scaleFactor: CGFloat = self.maxParallaxOffset / maxVerticalOffsetVisible
        var parallaxOffset: CGPoint = CGPointMake(0.0, offsetFromCenter.y * scaleFactor)
        
        return parallaxOffset
    }

}
