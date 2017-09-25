//
//  CLCaseNote.swift
//  CludeApp
//
//  Created by Reus on 11/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLCaseNote: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgWitness: UIImageView!
    @IBOutlet weak var tvCaseNotes: UITextView!
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var constraintGreen: NSLayoutConstraint!
    @IBOutlet weak var constraintImgWidht: NSLayoutConstraint!
    @IBOutlet weak var constraintLeadingTitle: NSLayoutConstraint!
    @IBOutlet weak var btnSeeHint: UIButton!
    
    var dismiss:((_ code:Bool)->Void)?
    var showHintTapped:((_ _tapped:Bool)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func close(_ sender: Any) {
        
        dismiss?(true)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        
        dismiss?(true)

    }
    @IBAction func seeHintTapped(_ sender: Any) {
        showHintTapped?(true)
        
    }
}
