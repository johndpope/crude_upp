//
//  CLNewEventTblCell.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLNewEventTblCell: UITableViewCell {

    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblWitnessCount: UILabel!
    @IBOutlet weak var lblSuspectsCount: UILabel!
    @IBOutlet weak var lblEvidenceCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func loadCellData(eventModel:EventList){
    
        self.lblEventName.text      = eventModel.name
        self.lblWitnessCount.text   = "\((eventModel.witnesses?.count)!)"
        self.lblSuspectsCount.text  = "\((eventModel.suspects?.count)!)"
        self.lblEvidenceCount.text  = "\((eventModel.evidences?.count)!)"
    }
    
}
