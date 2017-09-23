//
//  CLEvidenceVC.swift
//  CludeApp
//
//  Created by Reus on 11/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLEvidenceVC: UIViewController {

    @IBOutlet weak var collectionEvidence: UICollectionView!
    
    var arrayEvidence:[Evidences_db]?
    var selectedIndex = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sortedEvdns = arrayEvidence?.sorted(by: {$0.index < $1.index})
        arrayEvidence = sortedEvdns
        
        if !CLConstant.firstEvidence! {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showAlert(from: self,
                               title:CLConstant.Alert.dashTitle,
                               message:CLConstant.Alert.evidMsg,
                               buttonTitle:CLConstant.Alert.gotIt) { (tapped) in
                                if tapped{
                                }
                }
            }
        }
        
        
        CLConstant.firstEvidence = true
        
        collectionEvidence!.collectionViewLayout = UICollectionViewLayout().getLayout(atView: view)
        
        collectionEvidence.dataSource  = self
        collectionEvidence.delegate    = self
        

    }

    @IBAction func back(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension CLEvidenceVC: UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayEvidence!.count
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
        
        cell.imgEvidence.tag = indexPath.row
        cell.setCellData(evidence: (self.arrayEvidence?[indexPath.row])!)
        
        if (self.arrayEvidence?[indexPath.row].isCross)! {
           cell.imgCross.isHidden = false
        }else{
            cell.imgCross.isHidden = true
        }
        
        cell.lognPressDetect = {(tag) in
            
            self.arrayEvidence?[indexPath.row].isCross = !(self.arrayEvidence?[indexPath.row].isCross)!
            CLConstant.delegatObj.appDelegate.saveMagicalContext()
            
            self.selectedIndex.append(tag)
            self.collectionEvidence.reloadData()
        }
        
        return cell
        
    }
    
}
