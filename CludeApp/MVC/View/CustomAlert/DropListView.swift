//
//  DropListView.swift
//  CludeApp
//
//  Created by Vikash Kumar on 24/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit


class DropListView: UIView {
    @IBOutlet var actionView: UIView!
    @IBOutlet var yPosition: NSLayoutConstraint!
    @IBOutlet var xPosition: NSLayoutConstraint!
    
    enum Action {
        case GetAnswers, DeleteEvent
    }
    
    
    var action:((_ action:Int)->Void)?
    
    
    
    
    var actionBlock: ((Action)->Void)?
    
    class func show(in view: UIView, position: CGPoint, actionBlock:  @escaping (Action)->Void) {
        let items  = Bundle.main.loadNibNamed("DropListView", owner: nil, options: nil) as! [UIView]
        let cnfrmView = items.first as! DropListView
        cnfrmView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        
         var lvFrm = cnfrmView.actionView.frame
        lvFrm.origin.y = position.y
       
        //cnfrmView.actionView.frame = lvFrm
        
        cnfrmView.yPosition.constant = position.y
        //cnfrmView.xPosition.constant = position.x
        
        view.addSubview(cnfrmView)
        cnfrmView.actionBlock = actionBlock
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
    
    
    @IBAction func btnDeleteEvent (_ sender: UIButton) {
        actionBlock?(.DeleteEvent)
        self.hideWithAnimation()
    }
    
    @IBAction func btnGetAnsBoard (_ sender: UIButton) {
        actionBlock?(.GetAnswers)
        self.hideWithAnimation()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.hideWithAnimation()
    }
    
}
