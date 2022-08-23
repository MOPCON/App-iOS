//
//  SpeakerTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit
import Kingfisher

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
    @IBOutlet weak var tagViewHeightConstraint: NSLayoutConstraint!
    
    var tags: [Tag] = []
    
    func updateUI(speaker: Speaker) {
        
        tags = speaker.tags
        
        speakerAvatarImageView.kf.setImage(
            with: URL(string: speaker.img.mobile),
            placeholder: UIImage.asset(.fieldGameProfile)
        )
        
        let language = CurrentLanguage.getLanguage()
        
        switch language {
        
        case Language.chinese.rawValue:
            
            self.speakerJobLabel.text = speaker.jobTitle
            self.speakerNameLabel.text = speaker.name
        
        case Language.english.rawValue:
            
            self.speakerJobLabel.text = speaker.jobTitleEn
            self.speakerNameLabel.text = speaker.nameEn
        
        default:
            break
        }

        tagView.reloadData()

        /** 取得正確的 CollectionView Flowlayout Contentsize*/
        tagView.colletionView.collectionViewLayout.invalidateLayout()
        tagView.colletionView.collectionViewLayout.prepare();
        tagView.colletionView.layoutIfNeeded()
        
        self.tagViewHeightConstraint.constant = tagView.colletionView.collectionViewLayout.collectionViewContentSize.height + 5
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        baseView.layer.borderColor = UIColor.secondThemeColor?.cgColor
        baseView.layer.borderWidth = 1.0
        baseView.layer.cornerRadius = 6.0
        baseView.clipsToBounds = true

        selectionStyle = .none
    }
}

extension SpeakerTableViewCell: MPTagViewDataSource {
    
    func numberOfTags(_ tagView: MPTagView) -> Int {
        
        return tags.count
    }
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String {
        
        return tags[index].name
    }
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor? {
        
        return UIColor(hex: tags[index].color.mobile)
    }
}
