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
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButton: UIButton!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var delegate: WhichCellButtonDidTapped?
    
    var index:IndexPath?
    
    @IBAction func addToMySchedule(_ sender: UIButton) {
        
        guard let index = index else { return }
        
        if sender.image(for: .normal) == #imageLiteral(resourceName: "dislike_24") {
            
            addToMyScheduleButton.setImage(#imageLiteral(resourceName: "like_24"), for: .normal)
            
        } else {
            
            addToMyScheduleButton.setImage(#imageLiteral(resourceName: "dislike_24"), for: .normal)
            
        }
        
        delegate?.whichCellButtonDidTapped(sender: sender, index: index)
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        contentView.subviews.first?.layer.borderColor = UIColor.azure?.cgColor
        
        contentView.subviews.first?.layer.borderWidth = 1
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    func updateUI(agenda:Schedule.Payload.Agenda.Item.AgendaContent){
        
        let language = CurrentLanguage.getLanguage()
        
        switch language {
            
        case Language.chinese.rawValue:
            
            self.durationLabel.text = agenda.duration
            
            self.topicLabel.text = agenda.schedule_topic
            
            self.speakerLabel.text = agenda.name
            
            self.locationLabel.text = agenda.location
            
        case Language.english.rawValue:
            
            self.durationLabel.text = agenda.duration
            
            self.topicLabel.text = agenda.schedule_topic_en
            
            self.speakerLabel.text = agenda.name_en
            
            self.locationLabel.text = agenda.location
            
        default:
            
            break
        }
    }
}
