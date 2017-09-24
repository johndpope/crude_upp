//
//  UIViewController+Alert.swift
//  CludeApp
//
//  Created by Reus on 05/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIViewController{

    func showVocherPopUp(from:UIViewController, code:@escaping (_ voucherCode:String)->Void){
    
        let vocuherPopup = (Bundle.main.loadNibNamed("CLAddVoucherView",owner : nil,options:nil)?[0] as? UIView) as! CLAddVoucherView
        
        vocuherPopup.fromVC = from
        
        vocuherPopup.frame = from.view.frame
        
        vocuherPopup.dismiss = {(codeVoucher) in
        
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                vocuherPopup.removeFromSuperview()
                
            }, completion: nil)
            
            code(codeVoucher)
        }
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(vocuherPopup)
            }
            
        }) { (success) in}
        
        
    }

    func showCaseNotePopUp(from:UIViewController, text:String,testinomy:Bool,imgID:String, name:String){
        
        let vocuherPopup = (Bundle.main.loadNibNamed("CLCaseNote",owner : nil,options:nil)?[0] as? UIView) as! CLCaseNote
        
        
        vocuherPopup.frame = from.view.frame
        
        vocuherPopup.tvCaseNotes.text = text
        
        if testinomy {
            
            vocuherPopup.lblTitle.text = "Testimony"
        }
        
        
        if imgID.characters.count == 0 {
            
            vocuherPopup.constraintImgWidht.constant = 0
            vocuherPopup.constraintLeadingTitle.constant = 0
            vocuherPopup.constraintGreen.constant = 0
            
        }else{
        
            vocuherPopup.lblTitle.text = name
            vocuherPopup.viewActivity.startAnimating()
            vocuherPopup.imgWitness.sd_setImageWithPreviousCachedImage(with: URL(string: CLConstant.witnessBaseURL+(imgID)),
                                                               placeholderImage: nil,
                                                               options: SDWebImageOptions(rawValue: 0),
                                                               progress: nil) { (image, error, chache, url) in
                                                                DispatchQueue.main.async {
                                                                    vocuherPopup.viewActivity.stopAnimating()
                                                                }
                                                                
            }
            
        }
        
        vocuherPopup.dismiss = {(codeVoucher) in
            
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                vocuherPopup.removeFromSuperview()
                
            }, completion: nil)
            
        }
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(vocuherPopup)
            }
            
        }) { (success) in}
        
        
    }
    
    
    
    func showCoolDownPopUp(from:UIViewController, wrongAns:Bool){
        
        let vocuherPopup = (Bundle.main.loadNibNamed("CLSubmitSolutionView",owner : nil,options:nil)?[0] as? UIView) as! CLSubmitSolutionView
        
        vocuherPopup.frame = from.view.frame
        
        if wrongAns {
            
            vocuherPopup.lblTitle.text = "Cool-down needed"
            vocuherPopup.lblMessage.text = "Please wait for at least one minute before re-typing the question."
        }
        
        vocuherPopup.dismiss = {(codeVoucher) in
            
            if wrongAns {
                CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = false
            }
            
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                vocuherPopup.removeFromSuperview()
                
            }, completion: nil)
            
        }
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(vocuherPopup)
            }
            
        }) { (success) in}
        
        
    }
    
    
    func showSubmitPopUp(from:UIViewController, wrongAns:Bool){
        
        let vocuherPopup = (Bundle.main.loadNibNamed("CLSubmitSolutionView",owner : nil,options:nil)?[0] as? UIView) as! CLSubmitSolutionView
        
        vocuherPopup.frame = from.view.frame
        
        if wrongAns {
            
            vocuherPopup.lblTitle.text = "Wrong"
            vocuherPopup.lblMessage.text = "Unfortunately this is not correct.\nYou can try again in one minute"
        }
        
        vocuherPopup.dismiss = {(codeVoucher) in
            
            if wrongAns {
                CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = false
            }
            
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                vocuherPopup.removeFromSuperview()
                
            }, completion: nil)
            
        }
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(vocuherPopup)
            }
            
        }) { (success) in}
        
    }
        
        func showSubmitPopUp(from:UIViewController, title:String, message:String){
            
            let vocuherPopup = (Bundle.main.loadNibNamed("CLSubmitSolutionView",owner : nil,options:nil)?[0] as? UIView) as! CLSubmitSolutionView
            
            vocuherPopup.frame = from.view.frame
            
            vocuherPopup.lblTitle.text = title
            vocuherPopup.lblMessage.text = message
            
            
            vocuherPopup.dismiss = {(codeVoucher) in
                
                UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                    UIView.animate(withDuration: 0.3) {
                        from.view.layoutIfNeeded()
                    }
                    vocuherPopup.removeFromSuperview()
                    
                }, completion: nil)
                
            }
        
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(vocuherPopup)
            }
            
        }) { (success) in}
        
        
    }
    
    
    
    
    
    func showCannotFoundPopup(from:UIViewController,action: @escaping (_ actionTapped:Bool)->Void){
    
        
        CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = true
        
        let notFoundPopup = (Bundle.main.loadNibNamed("CLSubmitSolutionView",owner : nil,options:nil)?[0] as? UIView) as! CLSubmitSolutionView
        
        notFoundPopup.frame = from.view.frame
        
        notFoundPopup.lblTitle.text = "Cannot be Found"
        notFoundPopup.lblMessage.text = "This button will give you a instant access to the witness testimony in case a witness location cannot be accessed for any reason. Please use it spraingly as it comes with a time penalty of 15 minutes."
        notFoundPopup.btnClose.setTitle("I AGREE", for: .normal)
        
        
        notFoundPopup.dismiss = {(codeVoucher) in
            
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                notFoundPopup.removeFromSuperview()
                CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = false

                
            }, completion: nil)
            
           // return
            action(codeVoucher)
            
        }
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(notFoundPopup)
            }
            
        }) { (success) in}
    
    }
    
    func showCannotFoundHintPopup(from:UIViewController,action: @escaping (_ actionTapped:Bool)->Void){
        
        
        CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = true
        
        let notFoundPopup = (Bundle.main.loadNibNamed("CLSubmitSolutionView",owner : nil,options:nil)?[0] as? UIView) as! CLSubmitSolutionView
        
        notFoundPopup.frame = from.view.frame
        
        notFoundPopup.lblTitle.text = "Hint"
        notFoundPopup.lblMessage.text = "Using this option will give you a helping hand to solve this specific clue. However, using this option comes with a penalty of 5 minutes. Are you happy to procced?"
        notFoundPopup.btnClose.setTitle("I AGREE", for: .normal)
        
        
        notFoundPopup.dismiss = {(codeVoucher) in
            
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                notFoundPopup.removeFromSuperview()
                CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = false
                
                
            }, completion: nil)
            
            // return
            action(codeVoucher)
            
        }
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(notFoundPopup)
            }
            
        }) { (success) in}
        
    }
    
    
    
    func showAlert(from:UIViewController,title:String,message:String,buttonTitle:String, action:@escaping (_ actionTapped:Bool)->Void){
        
        let vocuherPopup = (Bundle.main.loadNibNamed("CLCustomAlert",owner : nil,options:nil)?[0] as? UIView) as! CLCustomAlert
        
        vocuherPopup.fromVC = from
        vocuherPopup.lblTitle.text = title
        vocuherPopup.lblMessage.text = message
        vocuherPopup.btnAction.setTitle(buttonTitle, for: .normal)
        
        vocuherPopup.frame = from.view.frame
        
        vocuherPopup.dismiss = {(codeVoucher) in
            
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                vocuherPopup.removeFromSuperview()
                
            }, completion: nil)
            
            action(codeVoucher)
        }
        
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(vocuherPopup)
            }
            
        }) { (success) in}
        
    }
    
    
    
    
    func showAlert(from: UIViewController,message:String){
    
        let alertController = UIAlertController(title: "Ooops!!",
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok",
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        
        DispatchQueue.main.async {
            from.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    // show question popups
    
    
    func showQuestionDailougeForWitness(from:UIViewController, witness:Witnesses_db_cludeUpp, action:@escaping (_ actionTapped:Bool)->Void){
    
    
        let questionView = (Bundle.main.loadNibNamed("CLQuestionView",owner : nil,options:nil)?[0] as? UIView) as! CLQuestionView
        
        questionView.frame = from.view.frame
        questionView.setupOptionTbl(witness: witness)
        
        questionView.answerClick = {(correct) in
        
            UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: { _ in
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                questionView.removeFromSuperview()
                
            }, completion: nil)
            
            action(correct)
            
        }
        
        UIView.transition(with: from.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    from.view.layoutIfNeeded()
                }
                from.view.addSubview(questionView)
            }
            
        }) { (success) in}
    
    }
        
        
}