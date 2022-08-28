//
//  ConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit
import SwiftUI

protocol ConferenceTableViewCellDelegate: AnyObject {
    
    func likeButtonDidTouched(_ cell: ConferenceTableViewCell)
}

class ConferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButton: UIButton!
    
    @IBOutlet weak var tagView: MPTagView!
    
    @IBOutlet weak var battleShipView: UIImageView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tagViewHeightConstraint: NSLayoutConstraint!
 
    weak var delegate: ConferenceTableViewCellDelegate?
    
    var tags: [Tag] = []

    var categoryStartIndex: Int = 0
    
    var index:IndexPath?
    
    var collectionViewHeight: Int = 18
    
    @IBAction func addToMySchedule(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        delegate?.likeButtonDidTouched(self)
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        contentView.subviews.first?.layer.borderColor = UIColor.secondThemeColor?.cgColor
        
        contentView.subviews.first?.layer.borderWidth = 1
        
        tagView.dataSource = self
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    func updateUI(room: Room, startDateFormate: String = "MM/dd HH:mm", endDateFormat: String = "HH:mm"){
        
        durationLabel.text = DateFormatter.string(for: room.startedAt, formatter: startDateFormate)! + " - " + DateFormatter.string(for: room.endedAt, formatter: endDateFormat)!
        
        locationLabel.text = room.room
        
        addToMyScheduleButton.isSelected = room.isLiked
        
        let language = CurrentLanguage.getLanguage()
        
        switch language {
            
        case Language.chinese.rawValue:
            
            topicLabel.text = room.topic
            
            speakerLabel.text = room.speakers.reduce("", { $0 + $1.name + " "})
            
        case Language.english.rawValue:
            
            topicLabel.text = room.topicEn
            
            speakerLabel.text = room.speakers.reduce("", { $0 + $1.nameEn + " "})
            
        default:
            
            break
        }
        
        generateTags(room: room)
        
        if(tags.count>0)
        {
            
            tagViewHeightConstraint.constant = ceil((bounds.size.height - ConferenceTableViewCellBasisHeight) / 30) * 30
        }
       
        tagView.reloadData()
    }
    
    func generateTags(room: Room) {
        
        tags = []
        
        if room.isKeynote {
            
            tags.append(TagFactory.keynoteTag())
        }
        
        if room.isOnline {
            
            tags.append(TagFactory.onlineTag())
        }
        
        if !room.recordable {
            
            tags.append(TagFactory.unrecordableTag())
        }
        
        if room.sponsorId != 0 {
            
            tags.append(TagFactory.partnerTag())
        }
        
        categoryStartIndex = tags.count - 1
        
        for category in room.tags {
            
            tags.append(category)
        }
    }
}

extension ConferenceTableViewCell: MPTagViewDataSource {
    
    func numberOfTags(_ tagView: MPTagView) -> Int {
        
        return tags.count
    }
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String {

        return tags[index].name
    }
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor? {
        
        return UIColor(hex: tags[index].color.mobile)
    }
    
    func viewType(_ tagView: MPTagView, index: Int) -> TagViewType {
        
        return (index > categoryStartIndex) ? .solid : .hollow
    }
}
