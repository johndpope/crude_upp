//
//  CLDashBoardTblVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLDashBoardTblVC: UITableViewController {

    @IBOutlet var btns: [UIButton]!
    
    var btnTapped:((_ index:Int)->Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        for btn in btns {
            btn.tag = btns.index(of: btn)!
            btn.addTarget(self,
                          action: #selector(btnTappedAction(sender:)),
                          for: .touchUpInside)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func btnTappedAction(sender:UIButton){
        btnTapped?(sender.tag)
    }
    
    
}
