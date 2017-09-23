//
//  CLSuspectsVC.swift
//  CludeApp
//
//  Created by Reus on 11/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLSuspectsVC: UIViewController {

    @IBOutlet weak var collecSuspect: UICollectionView!
    
    var arraysuspects:[Suspects_db]?
    var selectedIndex = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sortedSuspects = arraysuspects!.sorted(by: {$0.index < $1.index})
        
        arraysuspects = sortedSuspects
        
        if !CLConstant.firstSuspect! {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showAlert(from: self,
                               title:CLConstant.Alert.dashTitle,
                               message:CLConstant.Alert.suspectMsg,
                               buttonTitle:CLConstant.Alert.gotIt) { (tapped) in
                                if tapped{
                                }
                }
            }
        }
        
        
        CLConstant.firstSuspect = true
        
        
        collecSuspect!.collectionViewLayout = UICollectionViewLayout().getLayout(atView: view)
        
        collecSuspect.dataSource  = self
        collecSuspect.delegate    = self
    }

    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
extension CLSuspectsVC: UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arraysuspects!.count
        
    }
    
    
    // setting up cell according device
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height);
    }
    
    // make edge inset Zero
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    
    func collectionView(_ collectionView:  UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CLEvidenceCollectionCell.self), for: indexPath as IndexPath) as! CLEvidenceCollectionCell
        
        cell.setCellSuspectData(suspect: (self.arraysuspects?[indexPath.row])!)
        
        cell.imgEvidence.tag = indexPath.row
        
        if (self.arraysuspects?[indexPath.row].isCross)! {
            cell.imgCross.isHidden = false
        }else{
            cell.imgCross.isHidden = true
        }
        
        cell.lognPressDetect = {(tag) in
            
            self.arraysuspects?[indexPath.row].isCross = !(self.arraysuspects?[indexPath.row].isCross)!
            CLConstant.delegatObj.appDelegate.saveMagicalContext()
            
            self.selectedIndex.append(tag)
            self.collecSuspect.reloadData()
            
        }

        
        return cell
        
    }
    
}
