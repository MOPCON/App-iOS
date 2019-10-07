//
//  BreakTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class BreakTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breakStepLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .none
        
        self.isUserInteractionEnabled = false
    }
    
    func updateUI(startDate: String? = nil, endDate: String? = nil, event: String) {
        
        if let start = startDate,
           let end = endDate {
           
            timeLabel.text = start + " - " + end
            
            breakStepLabel.textAlignment = .right
        
        } else {
         
            timeLabel.text = ""
            
            breakStepLabel.textAlignment = .center
        }
    
        breakStepLabel.text = event
    }

}
