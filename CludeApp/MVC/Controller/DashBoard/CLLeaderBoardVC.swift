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
    
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnToday: UIButton!
    
    var eventID:String?
    var leaderBoard = [LeaderBoards]()
    var tempLeaderboardItems = [LeaderBoards]()
    
    var boolTapped:Bool? = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        CLApiManager().getLeaderBoard(gameID: eventID!) { (code, error, response, statusCode) in
            
            if let error = error {
                let message = error.code == -1009 ? "The internet connection appears to be offline." : "Something happen wrong."
                self.showSubmitPopUp(from: self, title: "OOPS!", message: message)
                
            } else if statusCode == 200 {
                for dicPost in response!.array! {
                    let leaderBoard = LeaderBoards.init(json: dicPost)
                    self.leaderBoard.append(leaderBoard)
                }
                
                self.tempLeaderboardItems = self.leaderBoard
                self.leaderBoard = self.tempLeaderboardItems.filter({$0.checkDate(timeStamp: $0.timestamp!/1000)})
                DispatchQueue.main.async {
                    self.tblLeaderBoard.reloadData()
                }
            } else{
                self.showSubmitPopUp(from: self, title: "OOPS!", message: "Something happen worng!")
            }
            
            self.tblLeaderBoard.dataSource = self
            self.tblLeaderBoard.delegate   = self
        }
        
        
        self.btnToday.setTitleColor(.white, for: .normal)
        self.btnToday.backgroundColor = UIColor(colorLiteralRed: 230.0/255.0, green: 10.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        
        self.btnYear.setTitleColor(.black, for: .normal)
        self.btnYear.backgroundColor = .white
    }
    
    @IBAction func back(_ sender: Any) {
        
        if boolTapped! {
            
            let aViewController = CLConstant.storyBoard.main.instantiateViewController(withIdentifier: String(describing: CLMainVC.self)) as! CLMainVC
            CLConstant.delegatObj.appDelegate.setInitalViewController(viewControler: aViewController)
            
        }else{
            _ = self.navigationController?.popViewController(animated: true)

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func year_btnClicked(_ sender: UIButton) {
        
        self.btnYear.setTitleColor(.white, for: .normal)
        self.btnYear.backgroundColor = UIColor(colorLiteralRed: 230.0/255.0, green: 10.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        
        self.btnToday.setTitleColor(.black, for: .normal)
        self.btnToday.backgroundColor = .white
        
        self.leaderBoard = tempLeaderboardItems
        self.tblLeaderBoard.reloadData()
    }
    
    @IBAction func today_btnClicked(_ sender: UIButton) {
        
        self.btnToday.setTitleColor(.white, for: .normal)
        self.btnToday.backgroundColor = UIColor(colorLiteralRed: 230.0/255.0, green: 10.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        
        self.btnYear.setTitleColor(.black, for: .normal)
        self.btnYear.backgroundColor = .white
        
        self.leaderBoard = self.tempLeaderboardItems.filter({$0.checkDate(timeStamp: $0.timestamp!/1000)})
        self.tblLeaderBoard.reloadData()
    }
    
    
}

extension CLLeaderBoardVC:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaderBoard.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CLLeaderBordTblCell.self)) as! CLLeaderBordTblCell
        let item = leaderBoard[indexPath.row]
        cell.lblTeamName.text = item.name!
        cell.lblRank.text     = "\(indexPath.row + 1)"
        cell.lblTime.text     = item.timeInHHMMSS
        return cell
        
    }
    
}
