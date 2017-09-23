//
//  CLAddVoucherView.swift
//  CludeApp
//
//  Created by Reus on 05/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLAddVoucherView: UIView {

    @IBOutlet weak var tfVoucher: UITextField!
    
    var dismiss:((_ code:String)->Void)?
    var fromVC:UIViewController?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func dismissTapped(_ sender: UIButton) {
       
         dismiss?("")
    }
    @IBAction func btnSubmitapped(_ sender: UIButton) {
        
        if (tfVoucher.text?.characters.count)! > 0 {
            
            dismiss?(self.tfVoucher.text!)
            
        }else{
        
            let alert = UIAlertController.init(title: "Oops!",
                                               message: "Please enter vocuher code",
                                               preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK",
                                              style: .default,
                                              handler: nil)
        
            alert.addAction(okAction)
            
            var hostVC = self.window?.rootViewController
            
            while let next = hostVC?.presentedViewController {
                hostVC = next
            }
        
            hostVC?.present(alert, animated: true, completion: nil)
            
        }
    }
}
