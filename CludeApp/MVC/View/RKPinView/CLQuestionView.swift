//
//  CLQuestionView.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLQuestionView: UIView {

    @IBOutlet weak var tblOptions: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblCongratulation: UILabel!
    
    var options = [WitnessOption_db]()
    var answerClick:((_ correct:Bool)->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
    }
    
    func setupOptionTbl(witness:Witnesses_db_cludeUpp){
        
        self.options = witness.witnessQuestion?.options?.allObjects as! [WitnessOption_db]
        self.lblQuestion.text = witness.witnessQuestion?.text
        
        self.tblOptions.register(UINib(nibName: "CLOptionTblCell", bundle: nil), forCellReuseIdentifier: "CLOptionTblCell")
        
        self.tblOptions.separatorColor = .clear
        
        self.tblOptions.dataSource = self
        self.tblOptions.delegate   = self
        
    }
    

}


extension CLQuestionView:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CLOptionTblCell") as! CLOptionTblCell
        cell.selectionStyle = .none
        
        cell.lblOption.text = self.options[indexPath.row].text
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.answerClick?(self.options[indexPath.row].isCorrect)
    }

}
