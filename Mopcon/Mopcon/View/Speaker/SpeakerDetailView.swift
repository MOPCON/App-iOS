//
//  SpeakerDetailView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class SpeakerDetailView: UIView {

    @IBOutlet weak var infoLabel: UILabel!

    func updateUI(info: String) {
        
        infoLabel.text = info
    }
}
