//
//  CLMainTblVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLMainTblVC: UITableViewController {

    var eventTapped:((_ event:Int)->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CLMainTblVC{

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return UITableViewAutomaticDimension
//    }
//    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return UITableViewAutomaticDimension
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.eventTapped?(indexPath.row)
    }

}
