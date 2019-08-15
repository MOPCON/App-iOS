//
//  CommunicationConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunicationConferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tiltleLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        contentView.subviews.first?.layer.borderColor = UIColor.azure?.cgColor
        
        contentView.subviews.first?.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    func updateUI(schedule:Schedule_unconf.Payload.Item) {

        timeLabel.text = schedule.duration
        
        tiltleLabel.text = schedule.topic
        
        speakerLabel.text = schedule.speaker
    }
    

}
