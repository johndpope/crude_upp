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
    
    var events = [Event_db_cludeUpp]()
    var boolCompletedEvent:Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if boolCompletedEvent!{
            let predicate1 = NSPredicate(format: "isCompleted = 1")
            events = Event_db_cludeUpp.mr_findAll(with: predicate1) as! [Event_db_cludeUpp]
        }else{
            let predicate = NSPredicate(format: "isCompleted = 0")
            events = Event_db_cludeUpp.mr_findAll(with: predicate) as! [Event_db_cludeUpp]
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
        cell.btnDelete.tag              = indexPath.row
        cell.btnShowLeaderBoard.tag     = indexPath.row
        
        cell.btnDelete.addTarget(self,
                                 action: #selector(deletedEvent(sender:)),
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
        
        let alert = UIAlertController(title: "Alert",
                                      message: "Are you sure want to delete?",
                                      preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let event = self.events[sender.tag]
            
            NSManagedObjectContext.mr_default().delete(event)
            _appDelegate.saveMagicalContext()
            self.events.remove(at: sender.tag)
            self.tblResumeEvent.reloadData()
            
        }
        
        let alertAction2 = UIAlertAction(title: "Cancel",
                                         style: .default) { (action) in
                                            
                                            
        }
        
        alert.addAction(alertAction)
        alert.addAction(alertAction2)
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
}
