//
//  CompleteCell.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/8/16.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol FieldGameCompleteViewDelegate: AnyObject {
    
    func didTouchRewardBtn()
}

class CompleteCell: UITableViewCell {

    weak var delegate: FieldGameCompleteViewDelegate?
    
    private var cellView: UIView?

    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var getButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView = contentView.subviews.first
        
        cellView?.layer.borderWidth = 1
    }
    
    func updateUI(with isCompleted: Bool, and isEnabled: Bool) {
        // change check image and backgroundColor and borderColor
        
        checkImageView.image = isCompleted ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck")
        
        titleLabel.text = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "領取獎勵" : "Get Rewards"
        
        descriptionLabel.text = getTitleText(with: isCompleted)
        
        descriptionLabel.textColor = isCompleted ? .white : .brownGray
        
        let buttonTitleColor = isEnabled ? UIColor.white : UIColor.brownGray
        
        getButton.setTitleColor(buttonTitleColor, for: .normal)
        
        getButton.backgroundColor = isEnabled ? .azure : UIColor.azure?.withAlphaComponent(0.15)
        
        getButton.isEnabled = isEnabled
        
        if isCompleted {
            
            hightlightStateLayout()
            
        } else {
            
            unHightlightStateLayout()
        }

    }
    
    private func getTitleText(with isCompleted: Bool) -> String {
        
        if isCompleted {
            
            return (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "已完成所有任務" : "Completed All missions"
            
        } else {
            
            return (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "需完成所有任務" : "Not Complete All missions"
        }
    }
    
    private func hightlightStateLayout() {
        
        cellView?.backgroundColor = UIColor.azure?.withAlphaComponent(0.3)
        
        cellView?.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func unHightlightStateLayout() {
        
        cellView?.backgroundColor = UIColor.clear
        
        cellView?.layer.borderColor = UIColor.azure?.cgColor
    }
    
    @IBAction func tapAction(_ sender: UIButton) {
        delegate?.didTouchRewardBtn()
    }
    
}


