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
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = false
        // Configure the view for the selected state
    }
    
    func updateUI(agenda:Schedule.Payload.Agenda.Item.AgendaContent) {
        self.breakStepLabel.text = agenda.schedule_topic
    }

}
