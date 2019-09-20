//
//  ConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol ConferenceTableViewCellDelegate {
    
    func whichCellButtonDidTapped(sender: UIButton,index:IndexPath)
}

class ConferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButton: UIButton!
    
    @IBOutlet weak var tagView: MPTagView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var delegate: ConferenceTableViewCellDelegate?
    
    var tags: [Tag] = []
    
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
        
        tagView.dataSource = self
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
    }
    
    func updateUI(room: Room){
        
        durationLabel.text = DateFormatter.string(for: room.startedAt, formatter: "HH:mm")! + " - " + DateFormatter.string(for: room.endedAt, formatter: "HH:mm")!
        
        locationLabel.text = room.room
        
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
        
        tags = room.tags
        
        tagView.reloadData()
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
        
        return UIColor(hex: tags[index].color)
    }
}
