//
//  CLMapListVC.swift
//  CludeApp
//
//  Created by Reus on 09/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//


protocol WitnessTapped {
    
    func didTapAtWintess(witness:Witnesses_db_cludeUpp)
    func didIntrogateWitness(witness:Witnesses_db_cludeUpp)
}

import UIKit

class CLMapListVC: UIViewController {

    @IBOutlet weak var tblMapList: UITableView!
    
    var witness:[Witnesses_db_cludeUpp]?
    
    var protocolWitness : WitnessTapped?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sortedwitness = witness?.sorted(by: {$0.index < $1.index})
        witness = sortedwitness
        
        self.tblMapList.dataSource = self
        self.tblMapList.delegate   = self
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func testomonyBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
        
        DispatchQueue.main.async {
            
            self.protocolWitness?.didTapAtWintess(witness: (self.witness?[sender.tag])!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


extension CLMapListVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (witness?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CLMapListTblCell.self)) as! CLMapListTblCell
        
        let witnes = witness![indexPath.row]
        cell.btnNotFound.tag = indexPath.row
        
        cell.btnNotFound.addTarget(self,
                                   action: #selector(showCannotFoundPopup(sender:)),
                                   for: .touchUpInside)
        
        
        
        cell.loadWintessData(witness: (witness?[indexPath.row])!)
        
        cell.btnNotFound.isHidden = witnes.introgatted
        cell.testomonyBtn.isEnabled = !witnes.introgatted
        cell.testomonyBtn.tag = indexPath.row
        cell.btnHint.tag = indexPath.row
        cell.btnHint.addTarget(self, action: #selector(showHintPopup(sender:)),
                               for: .touchUpInside)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func showCannotFoundPopup(sender:UIButton){
        
        if !(witness?[sender.tag].introgatted)! {
            
            self.showCannotFoundPopup(from: self,
                                      action: { (agree) in
                                        
                                        if agree{
                                        
                                            
                                            self.witness?[sender.tag].introgatted = true
                                            
                                            self.protocolWitness?.didTapAtWintess(witness: (self.witness?[sender.tag])!)

                                            
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.cannotFound), object: nil, userInfo: nil)
                                            
                                            self.tblMapList.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],
                                                                       with: UITableViewRowAnimation.none)
                                            
                                            self.showCaseNotePopUp(from: self,
                                                                      text: (self.witness?[sender.tag].statement)!,
                                                                      testinomy: true,
                                                                      imgID:"",
                                                                      name:"")
                                        }
            })
        }else{
        
            self.showCaseNotePopUp(from: self,
                                   text: (self.witness?[sender.tag].statement!)!,
                                   testinomy: true,
                                   imgID:(self.witness?[sender.tag].witnessImage?.id)!,
                                   name:(self.witness?[sender.tag].name!)!)
            
        }
    
    }
    
    
    func showHintPopup(sender:UIButton){
        
        self.showCannotFoundHintPopup(from: self) { (action) in
            if action{
               self.witness?[sender.tag].showHint = true
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.hint), object: nil, userInfo: nil)
                self.tblMapList.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],
                with: UITableViewRowAnimation.none)
            }
            
        }
    }

}
