//
//  CLAddTeamEmailTblVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLAddTeamEmailTblVC: UITableViewController {

   
    @IBOutlet weak var tfTeamname: UITextField!
    @IBOutlet weak var tfEmail1: UITextField!
    @IBOutlet weak var tfEmail2: UITextField!
    @IBOutlet weak var tfEmail3: UITextField!
    @IBOutlet weak var tfEmail4: UITextField!
    @IBOutlet weak var tfEmail5: UITextField!
    @IBOutlet weak var tfEmail6: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    
    func getEmailAddress(voucherCode:String,completion:((_ success:Bool,_ param:[String:Any]?)->Void)){
    
        
//        if (tfTeamname.text?.characters.count)! > 0 {
//            
//            let params:[String:Any] = ["voucher_code":voucherCode,
//                                      "player1email":tfEmail1.text!,
//                                      "player2email":tfEmail2.text!,
//                                      "player3email":tfEmail3.text!,
//                                      "player4email":tfEmail4.text!,
//                                      "player5email":tfEmail5.text!,
//                                      "player6email":tfEmail6.text!,
//                                      "name": tfTeamname.text!]
//            completion(true,params)
// 
//        }else{
//            self.showAlert(from: self,message:"Please enter team name")
// 
//        }
//       
        
        
        if (tfTeamname.text?.characters.count)! > 0 {
            
            if (tfEmail1.text?.characters.count)! == 0 || String().isValidEmail(testStr: tfEmail1.text!) {
                
                if (tfEmail2.text?.characters.count)! == 0 || String().isValidEmail(testStr: tfEmail2.text!) {
                    
                    if (tfEmail3.text?.characters.count)! == 0 || String().isValidEmail(testStr: tfEmail3.text!) {
                        
                        
                        if (tfEmail4.text?.characters.count)! == 0 || String().isValidEmail(testStr: tfEmail4.text!) {
                            
                            
                            if (tfEmail5.text?.characters.count)! == 0 || String().isValidEmail(testStr: tfEmail5.text!) {
                                
                                if (tfEmail6.text?.characters.count)! == 0 || String().isValidEmail(testStr: tfEmail6.text!) {
                                    
                                    let params:[String:Any] = ["voucher_code":voucherCode,
                                                               "player1email":tfEmail1.text!,
                                                               "player2email":tfEmail2.text!,
                                                               "player3email":tfEmail3.text!,
                                                               "player4email":tfEmail4.text!,
                                                               "player5email":tfEmail5.text!,
                                                               "player6email":tfEmail6.text!,
                                                               "name": tfTeamname.text!]
                                    completion(true,params)
                                    
                                }else{
                                
                                   self.showAlert(from: self,message:"Please enter player 6 vaild email")
                                }
                            }else{
                                
                                self.showAlert(from: self,message:"Please enter player 5 vaild email")
                            }
                        }else{
                            
                            self.showAlert(from: self,message:"Please enter player 4 vaild email")
                        }
                    }else{
                        
                        self.showAlert(from: self,message:"Please enter player 3 vaild email")
                    }
                }else{
                    
                    self.showAlert(from: self,message:"Please enter player 2 vaild email")
                }
                
            }else{
                
                self.showAlert(from: self,message:"Please enter player 1 vaild email")
            }
            
        }else{
           self.showAlert(from: self,message:"Please enter team name")
        }
        
        
        /* if (tfEmail1.text?.characters.count)! > 0 {
         if (tfEmail2.text?.characters.count)! > 0 {
         if (tfEmail3.text?.characters.count)! > 0 {
         if (tfEmail4.text?.characters.count)! > 0 {
         if (tfEmail5.text?.characters.count)! > 0 {
         if (tfEmail6.text?.characters.count)! > 0 {
         let param:[String:Any] = ["voucher_code":voucherCode,
         "player1email":tfEmail1.text!,
         "player2email":tfEmail2.text!,
         "player3email":tfEmail3.text!,
         "player4email":tfEmail4.text!,
         "player5email":tfEmail5.text!,
         "player6email":tfEmail6.text!,
         "name": tfTeamname.text!]
         
         completion(true,param)
         
         }else{
         self.showAlert(from: self,message:"Please enter player 6 email")
         }
         }else{
         self.showAlert(from: self,message:"Please enter player 5 email")
         }
         }else{
         self.showAlert(from: self,message:"Please enter player 4 email")
         }
         }else{
         self.showAlert(from: self,message:"Please enter player 3 email")
         }
         }else{
         self.showAlert(from: self,message:"Please enter player 2 email")
         }
         }else{
         self.showAlert(from: self,message:"Please enter player 1 email")
         }*/

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension String{
    
    
    func isValidEmail(testStr:String) -> Bool {
        
        if testStr.characters.count > 0
        {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
        return true
    }
    
}
