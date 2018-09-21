//
//  ConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol WhichCellButtonDidTapped {
    func whichCellButtonDidTapped(sender: UIButton,index:IndexPath)
}

class ConferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addToMyScheduleButton: UIButton!
    
    var delegate: WhichCellButtonDidTapped?
    var index:IndexPath?
    
    @IBAction func addToMySchedule(_ sender: UIButton) {
        guard let index = index else {return}
        if sender.image(for: .normal) == #imageLiteral(resourceName: "buttonStarNormal") {
            addToMyScheduleButton.setImage(#imageLiteral(resourceName: "buttonStarChecked"), for: .normal)
        } else {
            addToMyScheduleButton.setImage(#imageLiteral(resourceName: "buttonStarNormal"), for: .normal)
        }
        delegate?.whichCellButtonDidTapped(sender: sender, index: index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func updateUI(agenda:Schedule.Payload.Agenda.Item.AgendaContent){
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            self.categoryLabel.text = agenda.type
            self.topicLabel.text = agenda.schedule_topic
            self.speakerLabel.text = agenda.name
            self.locationLabel.text = agenda.location
        case Language.english.rawValue:
            self.categoryLabel.text = agenda.type
            self.topicLabel.text = agenda.schedule_topic_en
            self.speakerLabel.text = agenda.name_en
            self.locationLabel.text = agenda.location
        default:
            break
        }
    }
}
