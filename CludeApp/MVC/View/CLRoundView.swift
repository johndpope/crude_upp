//
//  CLRoundView.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CirleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    func commonInit(){
        self.layer.cornerRadius  = self.bounds.height / 2
        //self.layer.masksToBounds = true
        self.clipsToBounds       = true
    }
}
