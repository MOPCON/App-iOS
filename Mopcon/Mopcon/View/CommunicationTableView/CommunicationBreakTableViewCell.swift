//
//  CommunicationBreakTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunicationBreakTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breakTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func updateUI(schedule:Schedule_unconf.Payload.Item) {
        self.breakTitleLabel.text = schedule.topic
    }

}
