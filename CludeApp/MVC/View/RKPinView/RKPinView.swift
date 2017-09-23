//
//  RKPinView.swift
//  CludeApp
//
//  Created by Reus on 10/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class RKPinView: UIView {

    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var imgBox: UIImageView!
    @IBOutlet weak var witnessImage: UIImageView!
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func addLayer(){
        
//        witnessImage.layer.borderWidth = 8.0
//        witnessImage.layer.borderColor = UIColor.black.cgColor
    }
}
