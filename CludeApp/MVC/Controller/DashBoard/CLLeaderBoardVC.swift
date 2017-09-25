//
//  CLLeaderBoardVC.swift
//  CludeApp
//
//  Created by Reus on 24/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLLeaderBoardVC: UIViewController {
    
    @IBOutlet weak var tblLeaderBoard: UITableView!
    
    var eventID:String?
    var leaderBoard = [LeaderBoards]()
    var tempLeaderboardItems = [LeaderBoards]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        CLApiManager().getLeaderBoard(gameID: eventID!) { (code, error, response, statusCode) in
            
            if let error = error {
                self.showSubmitPopUp(from: self, title: "OOPS!", message: error.localizedDescription)
                
            } else if statusCode == 200 {
                for dicPost in response!.array! {
                    
                    let leaderBoard = LeaderBoards.init(json: dicPost)
                    self.leaderBoard.append(leaderBoard)
                    
                }
                
                self.tempLeaderboardItems = self.leaderBoard
                DispatchQueue.main.async {
                    self.tblLeaderBoard.reloadData()
                }
            } else{
                self.showSubmitPopUp(from: self, title: "OOPS!", message: "Something happen worng!")
            }
            
            self.tblLeaderBoard.dataSource = self
            self.tblLeaderBoard.delegate   = self
        }
        
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func year_btnClicked(_ sender: UIButton) {
        self.leaderBoard = tempLeaderboardItems
        self.tblLeaderBoard.reloadData()
    }
    
    @IBAction func today_btnClicked(_ sender: UIButton) {
        self.leaderBoard = tempLeaderboardItems.filter({$0.todayEvent})
        self.tblLeaderBoard.reloadData()
    }
    
    
}

extension CLLeaderBoardVC:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaderBoard.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CLLeaderBordTblCell.self)) as! CLLeaderBordTblCell
        let item = leaderBoard[indexPath.row]
        cell.lblTeamName.text = item.name
        cell.lblRank.text     = "\(item.score!)"
        cell.lblTime.text = item.timeInHHMMSS
        return cell
        
    }
    
}
