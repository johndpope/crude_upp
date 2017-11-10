//
//  CLNewEventVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLNewEventVC: UIViewController {

    @IBOutlet weak var tblNewEvent: UITableView!
    var arrayEventList = [EventList]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CLApiManager().getEventList { (code, error, response, statusCode) in
            if let error = error {
                let message = error.code == -1009 ? "The internet connection appears to be offline." : "Something happen wrong."
                self.showSubmitPopUp(from: self, title: "OOPS!", message: message)
                
            } else if statusCode == 200 {
                for dicPost in response!.array! {
                    let postList = EventList.init(json: dicPost)
                    self.arrayEventList.append(postList)
                }
                DispatchQueue.main.async {
                    self.tblNewEvent.reloadData()
                }
            } else{
                self.showSubmitPopUp(from: self, title: "OOPS!", message: "Something happen worng!")
            }

        }
        
        self.tblNewEvent.dataSource = self
        self.tblNewEvent.delegate   = self
        
    }

    @IBAction func btnBack(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}


extension CLNewEventVC: UITableViewDataSource, UITableViewDelegate{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:CLNewEventTblCell.self)) as! CLNewEventTblCell
        
        cell.loadCellData(eventModel:arrayEventList[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLEventDetailVC.self)) as! CLEventDetailVC
        
        aViewController.event = self.arrayEventList[indexPath.row]
        aViewController.witnessArray = self.arrayEventList[indexPath.row].witnesses
        
        DispatchQueue.main.async {
            
            self.navigationController?.pushViewController(aViewController, animated: true)
        }
    }
    

}
