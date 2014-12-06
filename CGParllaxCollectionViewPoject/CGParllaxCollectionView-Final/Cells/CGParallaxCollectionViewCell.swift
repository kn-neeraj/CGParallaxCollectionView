//
//  CGParallaxCollectionViewCell.swift
//  CGParllaxCollectionView-Final
//
//  Created by CocoaGarage on 04/06/14.
//  Copyright (c) 2014 CocoaGarage. All rights reserved.
//

import Foundation
import UIKit

class CGParallaxCollectionViewCell : UICollectionViewCell {
    var imageView: UIImageView = UIImageView(frame: CGRectZero)
    var maxParallaxOffset: CGFloat = 30.0
    var imageViewHeightConstraint:NSLayoutConstraint = NSLayoutConstraint()
    var imageViewCenterYConstraint:NSLayoutConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.setupImageView()
        self.setupConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.bounds
    }
    
    func setupImageView() {
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.image = nil
        self.contentView.addSubview(self.imageView)
    }
    
    func setupConstraints() {
        self.imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var horzLayoutLeftConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        var horzLayoutRightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        
        // Horizontal constraints
        self.contentView.addConstraint(horzLayoutLeftConstraint)
        self.contentView.addConstraint(horzLayoutRightConstraint)
        
        
        
        // Vertical constraints
        self.imageViewHeightConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        self.imageViewCenterYConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        self.contentView.addConstraint(self.imageViewHeightConstraint)
        self.contentView.addConstraint(self.imageViewCenterYConstraint)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.imageViewHeightConstraint.constant = 2 * self.maxParallaxOffset
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes!) {
        super.applyLayoutAttributes(layoutAttributes)
        if layoutAttributes == nil {
            return
        }
        if (!layoutAttributes.isKindOfClass(CGParallaxLayoutAttributes.self)) {
            return
        }
        var layoutAttr : CGParallaxLayoutAttributes = layoutAttributes as CGParallaxLayoutAttributes
        self.imageViewCenterYConstraint.constant = layoutAttr.parallaxOffset.y
    }

}
