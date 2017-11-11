//
//  CLSubmitSolutionView.swift
//  CludeApp
//
//  Created by Reus on 11/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLSubmitSolutionView: UIView {

    weak var fromVC:UIViewController?
    var dismiss:((_ code:Bool)->Void)?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var btnClose: UIButton!
    
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
        dismiss?(false)
    }
   
}
