//
//  CLAddTeamEmailVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLAddTeamEmailVC: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    var emailTblVC:CLAddTeamEmailTblVC?
    var voucherCode:String?
    var witnessArray:[Witnesses]?
    var event:EventList?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTblVC = storyboard!.instantiateViewController(withIdentifier: String(describing: CLAddTeamEmailTblVC.self)) as? CLAddTeamEmailTblVC
        
        addChildViewController(emailTblVC!)
        addSubview(subView: emailTblVC!.view, toView: viewContainer)
    }

    @IBAction func btnBackTapped(_ sender: UIButton) {
        
        
        _ = self.navigationController?.popToRootViewController(animated: true)
        
        //_ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        
        
        emailTblVC?.getEmailAddress(voucherCode: self.voucherCode!,
                                    completion: { (success, params) in
                if success{
                    
                    
                  self.view.isUserInteractionEnabled = false
                    
                  CLApiManager().addTeam(param: params!,
                                         completionHandler: { (code, error, response, statusCode) in
                                            self.view.isUserInteractionEnabled = true

                                            func showAlert(message: String) {
                                                let alert = UIAlertController.init(title: "Oops!!",
                                                                                   message: message,
                                                                                   preferredStyle: .alert)
                                                let action = UIAlertAction.init(title: "ok",
                                                                                style: .default,
                                                                                handler: nil)
                                                alert.addAction(action)
                                                
                                                self.present(alert, animated: true, completion: nil)
                                                
                                            }

                                            if let error = error {

                                                let message = error.code == -1009 ? "The internet connection appears to be offline." : "Something happen wrong."
                                                showAlert(message: message)
                                                
                                            } else if statusCode == 400{

                                                showAlert(message: "Please enter valid voucher code")
                                            }else{
                                                
                                                // sync event to coreData
                                                let teamName = response?.dictionary?["name"]?.string ?? ""
                                                Event_db_cludeUpp.syncEventInCoreData(event: self.event!,teamName:teamName)
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2,
                                                                              execute: {
                                                                                
                                                                                self.loadLocalEvent()
                                                })
                                                
                                                
                                                
                                            }
                  })
                                        
            }
                                        
        })
        
        /**/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    /*!
     * @abstract fetch request to particular event
     */
    
    func loadLocalEvent(){
    
        let Predicate = NSPredicate(format: "id = %@", (self.event?.id)!)
        
        if Event_db_cludeUpp.mr_countOfEntities(with: Predicate) > 0 {
            
            // save local event id
            UserDefaults.standard.set(self.event?.id, forKey: CLConstant.runningEventID)
            UserDefaults.standard.synchronize()
            
            let event_local = Event_db_cludeUpp.mr_findAll(with: Predicate)[0] as! Event_db_cludeUpp
            
            let aViewController = CLConstant.storyBoard.dashBoard.instantiateViewController(withIdentifier: String(describing: CLDashBoardVC.self)) as! CLDashBoardVC
            aViewController.event_local = event_local
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(aViewController, animated: true)
            }
        }
        
        
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
