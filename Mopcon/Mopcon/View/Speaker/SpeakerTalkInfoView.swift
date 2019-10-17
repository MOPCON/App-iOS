//
//  SpeakerTalkInfoView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol SpeakerTalkInfoViewDelegate: AnyObject {
    
    func didTouchCollectedButton(_ infoView: SpeakerTalkInfoView)
}

class SpeakerTalkInfoView: UIView {

    @IBOutlet weak var scheduleTopicLabel: UILabel!
    
    @IBOutlet weak var scheduleTimeLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var likedButton: UIButton!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var tagView: MPTagView!
    
    weak var delegate: SpeakerTalkInfoViewDelegate?
    
    @IBAction func collectionTopic(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        delegate?.didTouchCollectedButton(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        baseView.layer.cornerRadius = 6
        
        baseView.layer.borderColor = UIColor.azure?.cgColor
        
        baseView.layer.borderWidth = 1.0
    }

    func updateUI(topic: String, time: String, position: String, isCollected: Bool) {
        
        scheduleTopicLabel.text = topic
        
        scheduleTimeLabel.text = time
        
        positionLabel.text = position
        
        likedButton.isSelected = isCollected
    }
    
}
