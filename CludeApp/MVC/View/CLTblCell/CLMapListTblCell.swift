//
//  CLMapListTblCell.swift
//  CludeApp
//
//  Created by Reus on 09/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import SDWebImage


class CLMapListTblCell: UITableViewCell {

    @IBOutlet weak var viewIndicator: UIView!
    @IBOutlet weak var imgWitness: UIImageView!
    @IBOutlet weak var lblWitnessName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    @IBOutlet weak var btnHint: UIButton!
    @IBOutlet weak var lblTestiMony: UILabel!
    @IBOutlet weak var btnNotFound: UIButton!
    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var testomonyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func loadWintessData(witness:Witnesses_db_cludeUpp){
    
        self.viewActivity.startAnimating()
        
        self.imgWitness.sd_setImageWithPreviousCachedImage(with: URL(string: CLConstant.witnessBaseURL+(witness.witnessImage?.id!)!),
                                                           placeholderImage: #imageLiteral(resourceName: "loading.jpg"),
                                                           options: SDWebImageOptions(rawValue: 0),
                                                           progress: nil) { (image, error, chache, url) in
                                                            
                                                            
                                                            DispatchQueue.main.async {
                                                                
                                                                self.viewActivity.stopAnimating()
                                                            }
                                                            
        }
        
        self.lblWitnessName.text = witness.name
        if witness.introgatted {
            
            self.viewIndicator.backgroundColor = UIColor(colorLiteralRed:  0/255, green: 176/255, blue: 50/255, alpha: 1.0)
            self.lblTestiMony.text = witness.statement
            if witness.showHint{
                self.lblHint.text = "HINT : \((witness.hint)!)"
                self.btnHint.isHidden = true
            }else{
                self.lblHint.text = "\n"
                self.btnHint.isHidden = false
            }
        }else{
            //223 223 223
            self.lblTestiMony.text = "Interrogate".uppercased()
            self.btnHint.isHidden = true
            self.lblHint.text = ""
            self.viewIndicator.backgroundColor = UIColor(colorLiteralRed:  223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        }
        
    }

}
