//
//  CLMainVC.swift
//  CludeApp
//
//  Created by Reus on 02/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import Crashlytics

class CLMainVC: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    var mainTblVC:CLMainTblVC?
    var name: String!
    var xxxx: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTblVC = storyboard!.instantiateViewController(withIdentifier: String(describing: CLMainTblVC.self)) as? CLMainTblVC
        
        //let dic = ["name":"hmmm"]
        mainTblVC?.eventTapped = {(event) in
            if event == 0 {
                let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLNewEventVC.self)) as! CLNewEventVC
                DispatchQueue.main.async {
                     self.navigationController?.pushViewController(aViewController, animated: true)
                }

            }  else if event == 1{
            
                let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLEventResumeVC.self)) as! CLEventResumeVC
                aViewController.boolCompletedEvent = false
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(aViewController, animated: true)
                }
                
            }else if event == 2{
                
                let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLEventResumeVC.self)) as! CLEventResumeVC
                aViewController.boolCompletedEvent = true
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(aViewController, animated: true)
                }
            }
            
            //let hmm = dic["hmmm"]!

        }
        
        addChildViewController(mainTblVC!)
        addSubview(subView: mainTblVC!.view, toView: viewContainer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        
        parentView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subView]-0-|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subView]-0-|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        
    }
    
}
