//
//  MissionListHeaderView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class FieldGameHeaderView: UIView {
    
    @IBOutlet weak var rewardBtn: UIButton!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rewardBtn.layer.borderColor = UIColor.azure?.cgColor
        
        rewardBtn.layer.borderWidth = 1.0
        
        rewardBtn.layer.cornerRadius = 6.0
    }

}
