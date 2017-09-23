//
//  CLEventDetailVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLEventDetailVC: UIViewController {

    var event:EventList?
    var witnessArray:[Witnesses]?
    
    
    
    @IBOutlet weak var lblWitnessCount: UILabel!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblSuspectCount: UILabel!
    @IBOutlet weak var lblMurderWeapons: UILabel!
    @IBOutlet weak var tvEventDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblEventTitle.text    = event?.name
        self.lblWitnessCount.text  = "\((event?.witnesses?.count)!)"
        self.lblSuspectCount.text  = "\((event?.suspects?.count)!)"
        self.lblMurderWeapons.text = "\((event?.evidences?.count)!)"
        
        self.tvEventDescription.text = event?.caseNotes
    }

    
    @IBAction func back(_ sender: UIButton) {
        
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVoucherCodeTapped(_ sender: UIButton) {
        
        self.showVocherPopUp(from: self) { (vocuherCode) in
            
            if vocuherCode.characters.count > 0{
            
                CLApiManager().validateVoucherCode(param: ["voucher_code":vocuherCode], completionHandler: { (code, error, response, statusCode) in
                    
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
                        
                    } else {
                    
                        let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLAddTeamEmailVC.self)) as! CLAddTeamEmailVC
                        aViewController.voucherCode = vocuherCode
                        aViewController.event = self.event
                        DispatchQueue.main.async {
                            
                            self.navigationController?.pushViewController(aViewController, animated: true)
                        }
                    }
                    
                })
            
            }
            
        }
        
        
        /*let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLAddTeamEmailVC.self)) as! CLAddTeamEmailVC
         
         DispatchQueue.main.async {
         
         self.navigationController?.pushViewController(aViewController, animated: true)
         }*/
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
