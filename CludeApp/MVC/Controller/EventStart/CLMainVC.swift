//
//  CLMainVC.swift
//  CludeApp
//
//  Created by Reus on 02/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLMainVC: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    var mainTblVC:CLMainTblVC?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTblVC = storyboard!.instantiateViewController(withIdentifier: String(describing: CLMainTblVC.self)) as? CLMainTblVC
        
        
        mainTblVC?.eventTapped = {(event) in
        
            if event == 0 {
                
                let data = ConfirmAlertView.AlertData(title: "Auto DevOps can be activated for this project.",
                                                      message: "Auto DevOps can be activated for this project. It will automatically build, test, and deploy your application based on a predefined CI/CD configuration.",
                                                      btnTitle: "Sure, delete")
                
                ConfirmAlertView.show(in: self.view, alertData: data, actionBlock: { (action) in
                    
                })
                
                return
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
