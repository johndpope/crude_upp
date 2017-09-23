//
//  RKCalloutView.swift
//  CludeApp
//
//  Created by Reus on 14/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class RKCalloutView: UIView {

    @IBOutlet weak var imgWitness: UIImageView!
    @IBOutlet weak var lblWitnessName: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var btnCanNotFound: UIButton!
    var cannotFound: ((_ tapped:Bool)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   
    
    @IBAction func callCannotFound(_ sender: Any) {
        
        cannotFound?(true)

    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        if hitView != nil {
            superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let rect = self.btnCanNotFound.bounds
        var isInside = rect.contains(point)
        if !isInside {
            for view in subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    cannotFound?(true)
                    break
                }
            }
        }
        return isInside
    }
    
    
    
}
