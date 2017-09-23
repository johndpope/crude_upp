//
//  CLShadowView.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLShadowView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        if self.tag == 1 {
          self.setBorder()
        }else{
            self.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 0), radius: 1, scale: true)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if self.tag == 1 {
            self.setBorder()
        }else{
            self.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 0), radius: 1, scale: true)
        }

    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 0.1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func setBorder(){
    
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    

}
