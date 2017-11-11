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
    
    weak var dashBoardTblVC:CLDashBoardTblVC?
    var event:EventList?
    var event_local:Event_db_cludeUpp?
    var remainingSuspects = Suspects_db()
    var remainingWeapons  = Evidences_db()
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var timerCountdown = Timer()
    var timerCountdownInsert = Timer()
    var totalSeconds:Double = 0
    
    var startBackgroundTime:Double = 0
    var endBackgroundTime:Double   = 0
    
    var isUserStartPlaying = false
    
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        isUserStartPlaying = false

     NotificationCenter.default.addObserver(self, selector: #selector(terminationNotification(_:)), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)

     NotificationCenter.default.addObserver(self, selector: #selector(addCannotFoundSeconds(_:)), name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.cannotFound), object: nil)
        
      NotificationCenter.default.addObserver(self, selector: #selector(addhintSeconds(_:)), name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.hint), object: nil)
        
      NotificationCenter.default.addObserver(self, selector: #selector(pauseTimeForFiveMinute(_:)), name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.stoppper), object: nil)
        
        
      NotificationCenter.default.addObserver(self, selector: #selector(endBackgroundTask), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
     NotificationCenter.default.addObserver(self, selector: #selector(registerBackgroundTask), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        totalSeconds = (event_local?.timeConsume)!
        
        let hours = Int(totalSeconds) / 3600
        let minutes = Int(totalSeconds) / 60 % 60
        let seconds = Int(totalSeconds) % 60
        
        self.lblTime.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
        
//        if totalSeconds > 0 {
        if event_local!.isStarted {

            
            if  (event_local?.terminateTime)! > Double(0.0) {
                
                let context = NSManagedObjectContext.mr_default()
                
                event_local?.timeConsume = (event_local?.timeConsume)! + Date().timeIntervalSince1970 - (event_local?.terminateTime)!
                event_local?.terminateTime = 0
                
                totalSeconds = (event_local?.timeConsume)!
                
                context?.mr_saveToPersistentStoreAndWait()
                
            }
            
            isUserStartPlaying = true
            self.runTimer()
            
            
            
//            self.perform(#selector(self.insertSecondToDataBase),
//                         with: nil,
//                         afterDelay: 5.0)
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
                
                self.showStartGamePopup(isShowPopup: !self.event_local!.isStarted )
                
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
            
               
                
                self.showCaseNotePopUp(from: self,text :(self.event_local?.caseNotes)!, testinomy:false,imgID:"",name:"",showHint:true,hint:"",checkWitness: { (succes) in
                    
                    
                })
                
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
    
    
    
    func registerBackgroundTask() {
        
        self.timerCountdown.invalidate()
        self.startBackgroundTime = Date().timeIntervalSince1970
        
    }
    
    func endBackgroundTask() {
       
    
        self.timerCountdown.invalidate()
        let  diffrenceSeconds = Date().timeIntervalSince1970 - startBackgroundTime
        self.totalSeconds = self.totalSeconds + diffrenceSeconds
        self.insertWhileTerminate()
        self.startBackgroundTime = 0
        self.runTimer()
    }
    
    
    
    func submitSolutions(){
        let remainingWitness = (self.event_local?.witnesses?.allObjects as! [Witnesses_db_cludeUpp]).filter({$0.introgatted == false})
        
        if remainingWitness.count > 0 {
            self.incorrectSolutiosForWitness()
        }else {
            
            let remainSuspects:[Suspects_db]
                = (self.event_local?.suspects?.allObjects as! [Suspects_db]).filter({$0.isCross == false})
            
            if remainSuspects.count == 1{
                
                if remainSuspects[0].designation == "1"{
                    
                    let remainEvidence:[Evidences_db] = (self.event_local?.evidences?.allObjects as! [Evidences_db]).filter({$0.isCross == false})
                    
                    if remainEvidence.count == 1{
                        
                        if remainEvidence[0].designation == "1"{
                            
                            event_local?.endedAt = Date().timeIntervalSince1970
                            self.insertWhileTerminate()
                            
                            let date_start = Date(timeIntervalSince1970: (event_local?.startedAt)!)
                            let date_end   = Date(timeIntervalSince1970: (event_local?.endedAt)!) //current date time
                            
                            let milli_dateStart = date_start.millisecondsSince1970
                            let milli_dateEnd = date_end.millisecondsSince1970
                            
                            let time = abs((milli_dateEnd - milli_dateStart) + (Int32(event_local!.delayTime) * 1000))

                            let calendar = NSCalendar.current
                            
                            let components_sDate = calendar.dateComponents([.hour,.minute,.second ,.nanosecond], from: date_start)
                            let nanoSecondsStart = components_sDate.nanosecond!
                            
                            let components_eDate = calendar.dateComponents([.hour,.minute,.second ,.nanosecond], from: date_end)
                            let nanoSecondsEnd = components_eDate.nanosecond!

                           

                            let params = ["name":(event_local?.teamName)!,
                                          "time": "\(time)" ,
                                          "startedAt":"\(nanoSecondsStart)"  ,
                                          "endedAt":"\(nanoSecondsEnd)",
                                          "startedAt_mili": "\(milli_dateStart)",
                                          "endedAt_mili":milli_dateEnd as NSNumber,
                                          "minutesDelay":"\(((event_local?.delayTime)! / 60 ))"] as [String : Any]
                            
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
                                                
                                    if action == CorrectSolutionAlertView.Action.GetAnswers{
                                        
                                        let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLPdfSolutionVC.self)) as! CLPdfSolutionVC
                                        aViewController.pdfUrl = CLConstant.witnessBaseURL + (self.event_local?.pdfSolution)!
                                        aViewController.boolTapped = true
                                        DispatchQueue.main.async {
                                            self.navigationController?.present(aViewController,
                                                                               animated: true,
                                                                               completion: nil)
                                        }
                                    } else if action == CorrectSolutionAlertView.Action.SeeLeaderBoard {
                                        
                                        let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLLeaderBoardVC.self)) as! CLLeaderBoardVC
                                        aViewController.boolTapped = true
                                        aViewController.eventID = self.event_local?.id
                                        
                                        DispatchQueue.main.async {
                                            
                                            self.navigationController?.pushViewController(aViewController,
                                                                                          animated: true)
                                        }
                                        
                                    } else if action == CorrectSolutionAlertView.Action.Share {
                                        
                                        self.shareEvent()
                                    }else{
                                    
                                        let aViewController = CLConstant.storyBoard.main.instantiateViewController(withIdentifier: String(describing: CLMainVC.self)) as! CLMainVC
                                        CLConstant.delegatObj.appDelegate.setInitalViewController(viewControler: aViewController)
                                    }
                                    
                                    })
                                                                return
                                                            }  else if let error = error {
                                                                let message = error.code == -1009 ? "The internet connection appears to be offline." : "Something happen wrong."
                                                                self.showSubmitPopUp(from: self, title: "OOPS!", message: message)
                                                                
                                                            }
                            })
                            
                        }else{
                            showAlertForIncorrectCombination()
                        }
                    }else{
                        showAlertForIncorrectCombination()
                    }
                    
                }else{
                    showAlertForIncorrectCombination()
                }
            }else{
                showAlertForIncorrectCombination()
            }
            
        }
        
          }
    
    
    
    func showAlertForIncorrectCombination() {
        
        let alertData = ConfirmAlertView.AlertData(title: "Incorrect",
                                                   message: "Sorry Detective - That's the wrong combination, please try again",
                                                   btnTitle: "CLOSE")
        ConfirmAlertView.show(in: self.view, alertData: alertData,constant:false) { (action) in
            if action == .ok {
                
            }
        }

    }
    
    
    func incorrectSolutiosForWitness(){
    
//        Please visit all witnesses before submitting a solution
        
        let alertData = ConfirmAlertView.AlertData(title: "Not Yet",
                                                   message: "Please visit all witnesses before submitting a solution",
                                                   btnTitle: "CLOSE")
        ConfirmAlertView.show(in: self.view, alertData: alertData, constant:false) { (action) in
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
                                    self.event_local!.isStarted = true

                                    self.runTimer()
                                    self.perform(#selector(self.insertSecondToDataBase),
                                                 with: nil,
                                                 afterDelay: 10.0)

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
    
    
    
    func shareEvent() {
        let shareString = "I just solved a case! \n\n http://www.cluedupp.com"
        let shareController = UIActivityViewController(activityItems: [shareString], applicationActivities: nil)
        DispatchQueue.main.async {
            self.present(shareController, animated: true, completion: nil)
        }
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        //self.insertWhileTerminate()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func btnBackTapped(_ sender: UIButton) {
        
        // remove running event id
        
        timerCountdown.invalidate()
        
        UserDefaults.standard.removeObject(forKey: CLConstant.runningEventID)
        UserDefaults.standard.removeObject(forKey: CLConstant.runningEventTeamID)
        
        self.insertWhileTerminate()
        
        NotificationCenter.default.removeObserver(self)
        
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
        if event_local!.isStarted {
            timerCountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerCountdown.fire()
        }
    }
    
    
    func updateTimer() {
        
        totalSeconds += 1
        
        let hours   = Int(totalSeconds) / 3600
        let minutes = Int(totalSeconds) / 60 % 60
        let seconds = Int(totalSeconds) % 60
        
        self.lblTime.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)

        let context = NSManagedObjectContext.mr_default()
        event_local?.timeConsume = self.totalSeconds
        context?.mr_saveToPersistentStoreAndWait()
        
    }
    
    
    
    func insertWhileTerminate(){
    
        let context = NSManagedObjectContext.mr_default()
        event_local?.timeConsume = self.totalSeconds
        context?.mr_saveToPersistentStoreAndWait()

    }
    
    func terminationNotification(_ notification: NSNotification) -> Void {
        
        let context = NSManagedObjectContext.mr_default()
        event_local?.timeConsume = self.totalSeconds
        event_local?.terminateTime = Date().timeIntervalSince1970
        
        context?.mr_saveToPersistentStoreAndWait()
       
    }
        
    
    
    func insertSecondToDataBase(){
    
        let context = NSManagedObjectContext.mr_default()
        event_local?.timeConsume = self.totalSeconds
        context?.mr_saveToPersistentStoreAndWait()

    }

    
    
    // add 900 seconds for cannot found logic
    
    func addCannotFoundSeconds(_ notif:NSNotification)->Void{
        self.totalSeconds = self.totalSeconds + 900
        let context = NSManagedObjectContext.mr_default()
        event_local?.delayTime = (event_local?.delayTime)! + Double(900)
        event_local?.timeConsume = self.totalSeconds
        context?.mr_saveToPersistentStoreAndWait()
    }
    
    func addhintSeconds(_ notif:NSNotification)->Void{
        
        self.totalSeconds = self.totalSeconds + 300
        let context = NSManagedObjectContext.mr_default()
        event_local?.delayTime = (event_local?.delayTime)! + Double(300)
        event_local?.timeConsume = self.totalSeconds
        context?.mr_saveToPersistentStoreAndWait()
        
    }
    
    
    func pauseTimeForFiveMinute(_ notif:NSNotification)->Void{
        
        self.timerCountdown.invalidate()
        self.insertSecondToDataBase()

        DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
            self.runTimer()
        }
        
    }
    
    
}

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
        var millisecondsSince1970:Int {
            return Int((self.timeIntervalSince1970 * 1000.0).rounded())
        }
        
        init(milliseconds:Int) {
            self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
        }

}


