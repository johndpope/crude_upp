//
//  CLDashBoardVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import MagicalRecord

class CLDashBoardVC: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    var dashBoardTblVC:CLDashBoardTblVC?
    var event:EventList?
    var event_local:Event_db_cludeUpp?
    
    
    var remainingSuspects = Suspects_db()
    var remainingWeapons  = Evidences_db()
    
    
    var timerCountdown = Timer()
    var totalSeconds:Double = 0
    
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    NotificationCenter.default.addObserver(self, selector: #selector(terminationNotification(_:)), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)

     NotificationCenter.default.addObserver(self, selector: #selector(addCannotFoundSeconds(_:)), name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.cannotFound), object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(addhintSeconds(_:)), name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.hint), object: nil)
        
        totalSeconds = (event_local?.timeConsume)!
        
        let hours = Int(totalSeconds) / 3600
        let minutes = Int(totalSeconds) / 60 % 60
        let seconds = Int(totalSeconds) % 60
        
        self.lblTime.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
        
        if totalSeconds > 0 {
            
            self.runTimer()
            self.perform(#selector(self.insertSecondToDataBase),
                         with: nil,
                         afterDelay: 20.0)
        }
        
        
        if !CLConstant.firstHome! {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showAlert(from: self,
                               title:CLConstant.Alert.dashTitle,
                               message:CLConstant.Alert.dashMsg,
                               buttonTitle:CLConstant.Alert.dashButton) { (tapped) in
                                if tapped{
                                    let url = URL(string:"https://youtu.be/OuOaU9G0W70")!
                                    if UIApplication.shared.canOpenURL(url)  {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
                                }
                }
            }
        }
        
        CLConstant.firstHome = true
        
        
        dashBoardTblVC = storyboard!.instantiateViewController(withIdentifier: String(describing: CLDashBoardTblVC.self)) as? CLDashBoardTblVC
        
        UserDefaults.standard.set(self.event_local?.id, forKey: CLConstant.runningEventID)
        UserDefaults.standard.synchronize()

        UserDefaults.standard.set(self.event_local?.teamID, forKey: CLConstant.runningEventTeamID)
        UserDefaults.standard.synchronize()
        
        dashBoardTblVC?.btnTapped = {(index) in
            if index == 0 {
                
                self.showStartGamePopup(isShowPopup: self.totalSeconds > 0 ? false : true)
                
            }else if index == 4{
            
                let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLEvidenceVC.self)) as! CLEvidenceVC
                
                aViewController.arrayEvidence = (self.event_local?.evidences?.allObjects as! [Evidences_db]).sorted(by: { ($0.name?.characters.count)! > ($1.name?.characters.count)! })
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(aViewController, animated: true)
                }
            }else if index == 1{
                let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLSuspectsVC.self)) as! CLSuspectsVC
                
                aViewController.arraysuspects =  (self.event_local?.suspects?.allObjects as! [Suspects_db]).sorted(by: { ($0.name?.characters.count)! > ($1.name?.characters.count)! })
                
               // aViewController.arraysuspects = self.event_local?.suspects?.allObjects as? [Suspects_db]
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(aViewController, animated: true)
                }
            }else if index == 3{
            
                let url = URL(string:"https://youtu.be/OuOaU9G0W70")!
                if UIApplication.shared.canOpenURL(url)  {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }else if index == 5{
            
                self.showCaseNotePopUp(from: self,text :(self.event_local?.caseNotes)!, testinomy:false,imgID:"",name:"")
                
            }else if index == 2{
                
                self.submitSolutions()
            }
        }
        
        addChildViewController(dashBoardTblVC!)
        addSubview(subView: dashBoardTblVC!.view, toView: viewContainer)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.insertWhileTerminate()
    }
    
    
    
    func submitSolutions(){
        let remainingWitness = (self.event_local?.witnesses?.allObjects as! [Witnesses_db_cludeUpp]).filter({$0.introgatted == false})
        
        if remainingWitness.count > 0 {
            self.showSubmitPopUp(from: self, wrongAns: false)
        }else {
            
            let remainSuspects:[Suspects_db]
                = (self.event_local?.suspects?.allObjects as! [Suspects_db]).filter({$0.isCross == false})
            
            if remainSuspects.count == 1{
                
                if remainSuspects[0].designation == "1"{
                    
                    let remainEvidence:[Evidences_db] = (self.event_local?.evidences?.allObjects as! [Evidences_db]).filter({$0.isCross == false})
                    
                    if remainEvidence.count == 1{
                        
                        if remainEvidence[0].designation == "1"{
                            
                            event_local?.endedAt = Date().timeIntervalSince1970
                            CLConstant.delegatObj.appDelegate.saveMagicalContext()
                            
                            let time = ((event_local?.endedAt)! - (event_local?.startedAt)!) + (event_local?.delayTime)!
                            
                            let params = ["name":(event_local?.teamName)!,
                                          "time":time,
                                          "startedAt":(event_local?.startedAt)! ,
                                          "endedAt":(event_local?.endedAt)!,
                                          "startedAt_mili":(event_local?.startedAt)! * 1000,
                                          "endedAt_mili":((event_local?.endedAt)! * 1000),
                                          "minutesDelay":(event_local?.delayTime)!] as! [String : Any]
                            
                            print(params)
                            //nowDouble*1000
                            CLApiManager().submitSolutions(gameID: (event_local?.id)!,
                                                           param: params,
                                                           completionHandler: { (code, error, response, statusCode) in
                                                            
                                                            if statusCode == 200{
                                                                
                                                                self.event_local?.isCompleted = true
                                                                CLConstant.delegatObj.appDelegate.saveMagicalContext()
                                                                
                                                                self.timerCountdown.invalidate()
                                                                
                                                                UserDefaults.standard.removeObject(forKey: CLConstant.runningEventID)
                                                                UserDefaults.standard.removeObject(forKey: CLConstant.runningEventTeamID)

                                                                
                        CorrectSolutionAlertView.show(in: self.view,
                                description: (self.event_local?.outcome)!, actionBlock: { (action) in
                                                
                            if action == 0{
                                                                                
                                    let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLPdfSolutionVC.self)) as! CLPdfSolutionVC
                                    aViewController.pdfUrl = CLConstant.witnessBaseURL + (self.event_local?.pdfSolution)!
                                    DispatchQueue.main.async {
                                        
                                        self.navigationController?.present(aViewController,
                                                                           animated: true,
                                                                           completion: nil)
                                            }
                                        }
                                    })
                                    return
                                    }else{
                                    self.showSubmitPopUp(from: self, title: "OOPS!", message: (error?.localizedDescription)!)
                                    }
                            })
                            
                        }else{
                            showAlertForIncorrectCombination()
                           //   self.showSubmitPopUp(from: self, title: "Not Yet", message: "Combo of suspect and weapon is not correct")
                        }
                    }else{
                        showAlertForIncorrectCombination()
                       // self.showSubmitPopUp(from: self, title: "Not Yet", message: "Combo of suspect and weapon is not correct")
                    }
                    
                }else{
                    showAlertForIncorrectCombination()
                    //self.showSubmitPopUp(from: self, title: "Not Yet", message: "Combo of suspect and weapon is not correct")
                }
            }else{
                showAlertForIncorrectCombination()
                //self.showSubmitPopUp(from: self, title: "Not Yet", message: "Combo of suspect and weapon is not correct")
            }
            
        }
        
       // self.arrayWitnesses = self.arrayWitnesses?.filter { $0.introgatted == false }
        
        
        //                self.showSubmitPopUp(from:self,wrongAns:false)
        
    }
    
    
    
    func showAlertForIncorrectCombination() {
        
        let alertData = ConfirmAlertView.AlertData(title: "Incorrect",
                                                   message: "Sorry Detective - that's the wrong combination, please try again",
                                                   btnTitle: "CLOSE")
        ConfirmAlertView.show(in: self.view, alertData: alertData) { (action) in
            if action == .ok {
                
            }
        }

    }
    func showStartGamePopup(isShowPopup:Bool){
        
        
        if isShowPopup {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showAlert(from: self,
                               title:CLConstant.Alert.startGameTitle,
                               message:CLConstant.Alert.startGameMessage,
                               buttonTitle:CLConstant.Alert.startGameButton) { (tapped) in
                                if tapped{
                                    
                                    self.runTimer()
                                    self.perform(#selector(self.insertSecondToDataBase),
                                                 with: nil,
                                                 afterDelay: 20.0)
                                    
                                    let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLMapVC.self)) as! CLMapVC
                                    aViewController.event_local = self.event_local
                                    DispatchQueue.main.async {
                                        self.navigationController?.pushViewController(aViewController, animated: true)
                                    }
                                    
                                }
                }
            }
            
        }else{
            
            let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLMapVC.self)) as! CLMapVC
            aViewController.event_local = self.event_local
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(aViewController, animated: true)
            }
            
            
        }
        
        
    }
    
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        self.insertWhileTerminate()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func btnBackTapped(_ sender: UIButton) {
        
        // remove running event id
        
        timerCountdown.invalidate()
        
        UserDefaults.standard.removeObject(forKey: CLConstant.runningEventID)
        UserDefaults.standard.removeObject(forKey: CLConstant.runningEventTeamID)

        
        let aViewController = CLConstant.storyBoard.main.instantiateViewController(withIdentifier: String(describing: CLMainVC.self)) as! CLMainVC
        CLConstant.delegatObj.appDelegate.setInitalViewController(viewControler: aViewController)
        
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

extension CLDashBoardVC{


    func runTimer() {
        
        timerCountdown = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        timerCountdown.fire()
        
    }
    
    
    func updateTimer() {
        
        totalSeconds += 1
        let hours = Int(totalSeconds) / 3600
        let minutes = Int(totalSeconds) / 60 % 60
        let seconds = Int(totalSeconds) % 60
        
        self.lblTime.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        event_local?.timeConsume = self.totalSeconds
    }
    
    
    
    func insertWhileTerminate(){
    
        event_local?.timeConsume = self.totalSeconds
        CLConstant.delegatObj.appDelegate.saveMagicalContext()
    }
    
    func terminationNotification(_ notification: NSNotification) -> Void {
        
        event_local?.timeConsume = self.totalSeconds
        CLConstant.delegatObj.appDelegate.saveMagicalContext()

       
    }
        
    
    
    func insertSecondToDataBase(){
    
        event_local?.timeConsume = self.totalSeconds
        CLConstant.delegatObj.appDelegate.saveMagicalContext()
        
        self.perform(#selector(insertSecondToDataBase),
                     with: nil,
                     afterDelay: 20.0)
    }

    
    
    // add 900 seconds for cannot found logic
    
    func addCannotFoundSeconds(_ notif:NSNotification)->Void{
        self.totalSeconds = self.totalSeconds + 900
        event_local?.timeConsume = self.totalSeconds
        event_local?.delayTime = (event_local?.delayTime)! + Double(900)
        CLConstant.delegatObj.appDelegate.saveMagicalContext()
        
    }
    
    func addhintSeconds(_ notif:NSNotification)->Void{
        self.totalSeconds = self.totalSeconds + 300
        event_local?.timeConsume = self.totalSeconds
        event_local?.delayTime = (event_local?.delayTime)! + Double(300)
        CLConstant.delegatObj.appDelegate.saveMagicalContext()
        
    }
    
}




