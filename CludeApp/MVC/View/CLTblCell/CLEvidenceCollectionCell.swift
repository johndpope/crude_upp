//
//  CLEvidenceCollectionCell.swift
//  CludeApp
//
//  Created by Reus on 11/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import SDWebImage

class CLEvidenceCollectionCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imgEvidence: UIImageView!
    @IBOutlet weak var lblEvidenceName: UILabel!
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    @IBOutlet weak var imgCross: UIImageView!
    
    var lognPressDetect: ((_ index:Int)->Void)?
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.imgEvidence.addGestureRecognizer(longPressRecognizer)
       // self.imgCross.addGestureRecognizer(longPressRecognizer)
        longPressRecognizer.minimumPressDuration = 1
        
        
    }
    
    
    
    func setCellData(evidence:Evidences_db){
    
        
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
//        longPressRecognizer.minimumPressDuration = 1
//
//        self.imgEvidence.addGestureRecognizer(longPressRecognizer)
        
        self.viewActivity.stopAnimating()
        self.imgEvidence.sd_setImageWithPreviousCachedImage(with: URL(string: CLConstant.witnessBaseURL+(evidence.evidenceImage?.id!)!),
                                                           placeholderImage: #imageLiteral(resourceName: "loading.jpg"),
                                                           options: SDWebImageOptions(rawValue: 0),
                                                           progress: nil) { (image, error, chache, url) in
                                                            
                                                            
                                                            DispatchQueue.main.async {
                                                                
                                                                self.viewActivity.stopAnimating()
                                                            }
                                                            
        }
        
       self.lblEvidenceName.text = evidence.name
       
    }
    
    
    
    func setCellSuspectData(suspect: Suspects_db){
        
        self.viewActivity.stopAnimating()
        
        self.lblEvidenceName.text = suspect.name

        
        self.imgEvidence.sd_setImageWithPreviousCachedImage(with: URL(string: CLConstant.witnessBaseURL+(suspect.suspectImage?.id)!),
                                                            placeholderImage: #imageLiteral(resourceName: "loading.jpg"),
                                                            options: SDWebImageOptions(rawValue: 0),
                                                            progress: nil) { (image, error, chache, url) in
                                                                
                                                                DispatchQueue.main.async {
                                                                    self.viewActivity.stopAnimating()
                                                                }
                                                                
        }
        
    }
    
   
    
    func longPressed(_ sender: UILongPressGestureRecognizer)
    {
       
        //let imgView:UIImageView = sender.view as! UIImageView
        if (sender.state == UIGestureRecognizerState.ended) {
            lognPressDetect?(self.imgEvidence.tag)
        } else if (sender.state == UIGestureRecognizerState.began) {
           
        }
    }
    
    
    
    
    
}
