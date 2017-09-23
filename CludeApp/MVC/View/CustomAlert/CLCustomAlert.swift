//
//  CustomAlert.swift
//  CludeApp
//
//  Created by Reus on 10/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLCustomAlert: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    var fromVC:UIViewController?
    var dismiss:((_ code:Bool)->Void)?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    
    
    
    @IBAction func btntapped(_ sender: UIButton) {
        
         dismiss?(true)
    }
    @IBAction func dismiss(_ sender: UIButton) {
        
        dismiss?(false)
    }
}
