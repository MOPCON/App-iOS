//
//  SessionCollectionViewCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/26.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol SessionCollectionViewCellDelegate {
    
    func likeButtonDidTouched(_ cell: SessionCollectionViewCell)
}

class SessionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var tagView: MPTagView!
    
    var delegate: SessionCollectionViewCellDelegate?
    
    var tags: [Tag] = []
    
    var index:IndexPath?
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        
        delegate?.likeButtonDidTouched(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 6.0
        
        layer.borderWidth = 1.0
        
        layer.borderColor = UIColor.azure?.cgColor
        
        tagView.dataSource = self
    }
    
    func updateUI(_ room: Room){
        
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

    func updateUI(_ speaker: SponsorSpeaker) {
        
        durationLabel.text = DateFormatter.string(for: speaker.startedAt, formatter: "HH:mm")! + " - " + DateFormatter.string(for: speaker.endedAt, formatter: "HH:mm")!
        
        locationLabel.text = speaker.room
        
        let language = CurrentLanguage.getLanguage()
        
        switch language {
            
        case Language.chinese.rawValue:
            
            topicLabel.text = speaker.topicName
            
            speakerLabel.text = speaker.name
            
        case Language.english.rawValue:
            
            topicLabel.text = speaker.topicNameEn
            
            speakerLabel.text = speaker.nameEn
            
        default:
            
            break
        }
        
        tags = speaker.tags
        
        tagView.reloadData()
    }
}

extension SessionCollectionViewCell: MPTagViewDataSource {
    
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
