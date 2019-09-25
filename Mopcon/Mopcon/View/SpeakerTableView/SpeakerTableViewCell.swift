//
//  SpeakerTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit
import Kingfisher

protocol SpeakerTableViewCellDataSource: AnyObject {
    
    func numberOfTags(_ cell: SpeakerTableViewCell) -> Int
    
    func titleForTags(_ cell: SpeakerTableViewCell, index: Int) -> String
    
    func colorForTags(_ cell: SpeakerTableViewCell, index: Int) -> UIColor?
}

class SpeakerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var speakerAvatarImageView: UIImageView! {
        didSet {
            self.speakerAvatarImageView.makeCircle()
        }
    }
    
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerJobLabel: UILabel!
    @IBOutlet weak var tagView: MPTagView! {
        didSet {
            tagView.dataSource = self
        }
    }
    
    weak var dataSource: SpeakerTableViewCellDataSource?

    func updateUI(speaker: Speaker) {
        
//        if let resource = URL(string: speaker.picture) {
//        
//            self.speakerAvatarImageView.kf.setImage(with: resource)
//        
//        } else {
//        
//            self.speakerAvatarImageView.image = nil
//        }
//        
//        let language = CurrentLanguage.getLanguage()
//        
//        switch language {
//        
//        case Language.chinese.rawValue:
//            
//            self.speakerJobLabel.text = speaker.job
//            self.speakerNameLabel.text = speaker.name
//        
//        case Language.english.rawValue:
//            
//            self.speakerJobLabel.text = speaker.job
//            self.speakerNameLabel.text = speaker.name_en
//        
//        default:
//            break
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        baseView.layer.borderColor = UIColor.azure?.cgColor
        baseView.layer.borderWidth = 1.0
        baseView.layer.cornerRadius = 6.0
        baseView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
}

extension SpeakerTableViewCell: MPTagViewDataSource {
    
    func numberOfTags(_ tagView: MPTagView) -> Int {
        
        return dataSource?.numberOfTags(self) ?? 0
    }
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String {
        
        return dataSource?.titleForTags(self, index: index) ?? String.empty
    }
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor? {
        
        return dataSource?.colorForTags(self, index: index)
    }
}
