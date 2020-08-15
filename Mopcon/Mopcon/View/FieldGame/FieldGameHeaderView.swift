//
//  MissionListHeaderView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol FieldGameHeaderViewDelegate: AnyObject {
    
    func didTouchRewardBtn(_ headerView: FieldGameHeaderView)
}

class FieldGameHeaderView: UIView {
    
    @IBOutlet weak var rewardBtn: UIButton!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    weak var delegate: FieldGameHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rewardBtn.layer.borderColor = UIColor.secondThemeColor?.cgColor
        
        rewardBtn.layer.borderWidth = 1.0
        
        rewardBtn.layer.cornerRadius = 6.0
    }
    
    @IBAction func didTouchRewardBtn(_ sender: UIButton) {
        
        delegate?.didTouchRewardBtn(self)
    }

}
