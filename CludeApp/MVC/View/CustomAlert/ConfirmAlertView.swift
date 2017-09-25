//
//  ConfirmAlertView.swift
//  CludeApp
//
//  Created by Vikash Kumar on 23/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class ConfirmAlertView: UIView {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var actionButton: UIButton!
    
    enum Action {
        case ok, cancel
    }
    
    struct AlertData {
        var title: String
        var message: String
        var btnTitle: String
    }
    
    var alertData: AlertData! {
        didSet {
            self.lblTitle.text = alertData.title
            self.lblMessage.text = alertData.message
            self.actionButton.setTitle(alertData.btnTitle, for: .normal)
        }
    }
    
    var actionBlock: (Action)-> Void = {_ in}
    
    class func show(in view: UIView, alertData: AlertData, actionBlock:  @escaping (Action)->Void) {
        let items  = Bundle.main.loadNibNamed("ConfirmAlertView", owner: nil, options: nil) as! [UIView]
        let cnfrmView = items.first as! ConfirmAlertView
       
        cnfrmView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        view.addSubview(cnfrmView)

        cnfrmView.actionBlock = actionBlock
        cnfrmView.alertData = alertData
        cnfrmView.showWithAnimation()
    }
    
    func showWithAnimation() {
        self.alpha = 0
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
    }
    
    func hideWithAnimation() {
        self.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }

    
    @IBAction func btnAction(_ sender: UIButton) {
        actionBlock(.ok)
        self.hideWithAnimation()
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        actionBlock(.cancel)
        self.hideWithAnimation()
    }

}







class CorrectSolutionAlertView: UIView {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var txtvDescription: UITextView!
    
    enum Action {
        case GetAnswers, SeeLeaderBoard, Share
    }
    
    
    var action:((Action)->Void)?
    
    
    
    var _description = "" {
        didSet {
            self.txtvDescription.text = _description
        }
    }
    
    var actionBlock: ((Action)->Void)?
    
    class func show(in view: UIView, description: String, actionBlock:  @escaping (Action)->Void) {
        let items  = Bundle.main.loadNibNamed("CorrectSolutionAlertView", owner: nil, options: nil) as! [UIView]
        let cnfrmView = items.first as! CorrectSolutionAlertView
        cnfrmView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)

        view.addSubview(cnfrmView)
        cnfrmView.actionBlock = actionBlock
        cnfrmView._description = description
        cnfrmView.showWithAnimation()
    }
    
    func showWithAnimation() {
        self.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hideWithAnimation() {
        self.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }
    
    
    @IBAction func btnSeeLeaderBoard (_ sender: UIButton) {
        actionBlock?(CorrectSolutionAlertView.Action.SeeLeaderBoard)
        self.hideWithAnimation()
    }
    
    @IBAction func btnGetAnsBoard (_ sender: UIButton) {
        actionBlock?(CorrectSolutionAlertView.Action.GetAnswers)

        self.hideWithAnimation()
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        self.hideWithAnimation()
    }
    
    @IBAction func facebook_btnClicked(_ sender: UIButton) {
        actionBlock?(CorrectSolutionAlertView.Action.Share)
    }
    
}

