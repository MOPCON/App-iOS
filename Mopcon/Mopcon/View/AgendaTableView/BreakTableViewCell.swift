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
    
    func updateUI(agenda:Schedule.Payload.Agenda.Item.AgendaContent) {
        
        timeLabel.text = agenda.duration
    
        let language = CurrentLanguage.getLanguage()
        
        switch language {
        
        case Language.chinese.rawValue:
        
            breakStepLabel.text = agenda.schedule_topic
            
        case Language.english.rawValue:
            
            breakStepLabel.text = agenda.schedule_topic_en
        
        default:
        
            break
        }
    }

}
