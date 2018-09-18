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
    
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var speakerAvatarImageView: UIImageView! {
        didSet {
            self.speakerAvatarImageView.makeCircle()
        }
    }
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerCompanyLabel: UILabel!
    @IBOutlet weak var speakerJobLabel: UILabel!
    

    func updateUI(speaker:Speaker.Payload){
        if let resource = URL(string: speaker.picture) {
            self.speakerAvatarImageView.kf.setImage(with: resource)
        }
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            self.speakerJobLabel.text = speaker.job
            self.speakerNameLabel.text = speaker.name
            self.speakerCompanyLabel.text = speaker.company
        case Language.english.rawValue:
            self.speakerJobLabel.text = speaker.job
            self.speakerNameLabel.text = speaker.name_en
            self.speakerCompanyLabel.text = speaker.company
        default:
            break
        }
        
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

}
