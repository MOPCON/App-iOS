//
//  PresentCell.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/8/16.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol FieldGameRewardViewDelegate: AnyObject {
    
    func didTouchRewardBtn(with uid: String)
}

class PresentCell: UITableViewCell {
    
    weak var delegate: FieldGameRewardViewDelegate?
    
    private var uid: String?
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var presentImageView: UIImageView!
    
    @IBOutlet weak var presentNameLabel: UILabel!
    
    @IBOutlet weak var presentDescriptionLabel: UILabel!
    
    @IBOutlet weak var getButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        presentImageView.makeCircle()
    
        baseView.layer.cornerRadius = 6
        
        baseView.layer.borderWidth = 1.0
        
        baseView.layer.borderColor = UIColor.azure?.cgColor
    }
    
    func updateUI(with reward: Reward) {
        
        uid = reward.uid
        
        presentImageView.loadImage(reward.image)
        
        presentNameLabel.text = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? reward.name : reward.nameEn
        
        presentDescriptionLabel.text = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? reward.description : reward.descriptionEn
        
        updateButton(with: (reward.redeemed == 1))
    }
    
    func updateButton(with isRedeemed: Bool) {
        
        getButton.isEnabled = !isRedeemed
        
        getButton.backgroundColor = isRedeemed ? .clear : .azureTwo
        
        getButton.layer.borderWidth = isRedeemed ? 1 : 0
        
        getButton.layer.borderColor = isRedeemed ? UIColor(hex: "#979797")?.cgColor : UIColor.clear.cgColor
        
        let titleColor = isRedeemed ? UIColor.brownGray : .white
        
        getButton.setTitleColor(titleColor, for: .normal)
        
        if isRedeemed {
            
            let title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "已兌換" : "Redeemed"
            
            getButton.setTitle(title, for: .normal)
            
        } else {
            
            let title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "直接兌換" : "Redeem"
            
            getButton.setTitle(title, for: .normal)
        }
    }
    
    @IBAction func tapAction(_ sender: UIButton) {
        if let uid = self.uid {
            delegate?.didTouchRewardBtn(with: uid)
        }        
    }
    
}
