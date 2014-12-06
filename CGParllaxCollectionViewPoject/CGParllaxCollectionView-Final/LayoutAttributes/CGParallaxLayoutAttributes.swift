//
//  CGParallaxLayoutAttributes.swift
//  CGParllaxCollectionView-Final
//
//  Created by CocoaGarage on 04/06/14.
//  Copyright (c) 2014 CocoaGarage. All rights reserved.
//

import Foundation
import UIKit

class CGParallaxLayoutAttributes : UICollectionViewLayoutAttributes {
    var parallaxOffset : CGPoint
    override init() {
        self.parallaxOffset = CGPointZero
        super.init()
    }
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        var copy: CGParallaxLayoutAttributes = super.copyWithZone(zone) as CGParallaxLayoutAttributes
        copy.parallaxOffset = self.parallaxOffset
        return copy
    }
    
    override func isEqual(object: AnyObject!) -> Bool  {
        
        if (!object.isKindOfClass(CGParallaxLayoutAttributes.self)) {
            return false
        }
        var otherObject: CGParallaxLayoutAttributes = object as CGParallaxLayoutAttributes
        
        if !CGPointEqualToPoint(otherObject.parallaxOffset, self.parallaxOffset) {
            return false
        }
        return super.isEqual(otherObject)
    }
    
    
}

