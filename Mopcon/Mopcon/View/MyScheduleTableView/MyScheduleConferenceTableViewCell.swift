//
//  MyScheduleConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/15.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol DeleteMySchedule {
    func deleteSchedule(indexPath:IndexPath)
}

class MyScheduleConferenceTableViewCell: UITableViewCell {
    
    var delegate:DeleteMySchedule?
    var indexPath:IndexPath?
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func deleteSchedule(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }
        delegate?.deleteSchedule(indexPath: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func update(mySchedule:Schedule.Payload.Agenda.Item.AgendaContent) {
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            self.typeLabel.text = mySchedule.category
            self.titleLabel.text = mySchedule.schedule_topic
            self.speakerLabel.text = mySchedule.name
            self.floorLabel.text = mySchedule.location
        case Language.english.rawValue:
            self.typeLabel.text = mySchedule.category
            self.titleLabel.text = mySchedule.schedule_topic_en
            self.speakerLabel.text = mySchedule.name_en
            self.floorLabel.text = mySchedule.location
        default:
            break
        }
    }
}
