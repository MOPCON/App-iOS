//
//  SpeakerView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class SpeakerView: UIView {

    @IBOutlet weak var speakerImageView: UIImageView!
    
    @IBOutlet weak var speakerJobLabel: UILabel!
    
    @IBOutlet weak var speakerNameLabel: UILabel!
    
    func updateUI(image: String, name: String, job: String) {
        
        speakerImageView.loadImage(image)
        
        speakerJobLabel.text = job

        speakerNameLabel.text = name
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        speakerImageView.makeCircle()
    }
}
