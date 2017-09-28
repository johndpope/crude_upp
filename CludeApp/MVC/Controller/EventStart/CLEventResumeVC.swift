//
//  CLEventResumeVC.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit



class CLEventResumeVC: UIViewController {

    @IBOutlet weak var tblResumeEvent: UITableView!
    @IBOutlet weak var menuPopView: UIView!
    
    @IBOutlet weak var viewNotFound: UIView!
   
    @IBOutlet weak var lblNotFound:UILabel!
    
    var events = [Event_db_cludeUpp]()
    var boolCompletedEvent:Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if boolCompletedEvent!{
            
            let predicate1 = NSPredicate(format: "isCompleted = 1")
            events = Event_db_cludeUpp.mr_findAll(with: predicate1) as! [Event_db_cludeUpp]
            lblNotFound.text = "You have no completed cases."

            if events.count > 0 {
                self.viewNotFound.isHidden = true
                self.tblResumeEvent.isHidden = false
            }else{
                self.viewNotFound.isHidden = false
                self.tblResumeEvent.isHidden = true

            }
            
        }else{
            let predicate = NSPredicate(format: "isCompleted = 0")
            events = Event_db_cludeUpp.mr_findAll(with: predicate) as! [Event_db_cludeUpp]
            lblNotFound.text = "You have no paused cases."

            if events.count > 0 {
                self.viewNotFound.isHidden = true
                self.tblResumeEvent.isHidden = false

            }else{
                self.viewNotFound.isHidden = false
                self.tblResumeEvent.isHidden = true

            }
        }
        
        self.tblResumeEvent.dataSource = self
        self.tblResumeEvent.delegate   = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func bacKTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    

}

extension CLEventResumeVC:UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if boolCompletedEvent!{
            if events.count > 0 {
                self.viewNotFound.isHidden = true
                self.tblResumeEvent.isHidden = false
            }else{
                self.viewNotFound.isHidden = false
                self.tblResumeEvent.isHidden = true
                
            }
        }else{
            
            if events.count > 0 {
                self.viewNotFound.isHidden = true
                self.tblResumeEvent.isHidden = false
                
            }else{
                self.viewNotFound.isHidden = false
                self.tblResumeEvent.isHidden = true
                
            }
        }
        
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing :CLResumeEventTblCell.self)) as! CLResumeEventTblCell
        
        cell.lblEventName.text = events[indexPath.row].name
        
        cell.btnDelete.isHidden         = boolCompletedEvent!
        cell.viewLeaderBoard.isHidden   = !boolCompletedEvent!
        cell.btnMenu.isHidden           = !boolCompletedEvent!

        cell.btnDelete.tag              = indexPath.row
        cell.btnShowLeaderBoard.tag     = indexPath.row
        cell.btnMenu.tag                = indexPath.row
        cell.btnDelete.addTarget(self,
                                 action: #selector(deletedEvent(sender:)),
                                 for: .touchUpInside)
        cell.btnMenu.addTarget(self,
                                 action: #selector(showMenuPopup(_:)),
                                 for: .touchUpInside)

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if boolCompletedEvent! {
            
        }else{
            
            let aViewController = CLConstant.storyBoard.dashBoard.instantiateViewController(withIdentifier: String(describing: CLDashBoardVC.self)) as! CLDashBoardVC
            
            aViewController.event_local = events[indexPath.row]
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(aViewController, animated: true)
            }
        }

    }
    
    func deletedEvent(sender:UIButton){
        
        let alertData = ConfirmAlertView.AlertData(title: "Are you sure?",
                                                   message: "You are about to delete this game permanetly",
                                                   btnTitle: "I AM SURE, DELETE IT")
        
        
        ConfirmAlertView.show(in: self.view, alertData: alertData, constant:true) { (action) in
            if action == .ok {
                let event = self.events[sender.tag]
                
                NSManagedObjectContext.mr_default().delete(event)
                _appDelegate.saveMagicalContext()
                self.events.remove(at: sender.tag)
                self.tblResumeEvent.reloadData()

            }
        }
    }
    
    func showMenuPopup(_ sender: UIButton)  {
        let fr = self.view.convert(sender.bounds, from: sender)
        
        DropListView.show(in: self.view, position: fr.origin) { (action) in //GetAnswers, DeleteEvent
            if action == .GetAnswers {
                let event = self.events[sender.tag]

                let aViewController = CLConstant.storyBoard.dashBoard.instantiateViewController(withIdentifier: String(describing: CLPdfSolutionVC.self)) as! CLPdfSolutionVC
                aViewController.pdfUrl = CLConstant.witnessBaseURL + (event.pdfSolution)!
               
                DispatchQueue.main.async {
                    
                    self.navigationController?.present(aViewController,
                                                       animated: true,
                                                       completion: nil)
                }

            } else if action == .DeleteEvent {
                self.deletedEvent(sender: sender)
            }
        }
    }
    
    @IBAction func showLeaderboard_btnClicked(_ sender: UIButton) {
        let envent = events[sender.tag]
        let aViewController = CLConstant.storyBoard.dashBoard.instantiateViewController(withIdentifier: String(describing: CLLeaderBoardVC.self)) as! CLLeaderBoardVC
        
        aViewController.eventID = envent.id
        
        self.navigationController?.pushViewController(aViewController,
                                                      animated: true)
        
    }

}
