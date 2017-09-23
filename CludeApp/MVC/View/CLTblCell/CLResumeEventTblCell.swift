//
//  CLResumeEventTblCell.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

class CLResumeEventTblCell: UITableViewCell {

    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewLeaderBoard: UIView!
    @IBOutlet weak var btnShowLeaderBoard: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
