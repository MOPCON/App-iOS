//
//  MissionCollectionViewCell.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/5.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class MissionCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
        self.clipsToBounds = true
    }
    
    func updateUI(item: Quiz.Item) {
        
        typeLabel.text = item.type
        titleLabel.text = item.title
        
        guard let quizStatus = QuizStatus(rawValue: item.status) else {
            return
        }
        
        let backView = UIView()
        backView.frame = self.bounds
        backView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2, alpha: 0.7)
        backView.isHidden = true
        
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: self.bounds.height / 4 * 3, width: self.bounds.width, height: 3)
        lineView.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 0.5)
        lineView.isHidden = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        
        let iconImageView = UIImageView()
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let messageLabel = UILabel()
        messageLabel.font = UIFont(name: "PingFangTC-Medium", size: 14)
        messageLabel.textAlignment = .center
        messageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        switch quizStatus {
        case .success:
            iconImageView.image = #imageLiteral(resourceName: "iconSucess")
            messageLabel.text = "挑戰成功"
            messageLabel.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
            backView.isHidden = false
            lineView.isHidden = false
            stackView.isHidden = false
        case .fail:
            iconImageView.image = #imageLiteral(resourceName: "iconFailed")
            messageLabel.text = "挑戰失敗"
            messageLabel.textColor = #colorLiteral(red: 0.8196078431, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
            backView.isHidden = false
            lineView.isHidden = false
            stackView.isHidden = false
        case .lock:
            lockImageView.isHidden = false
        case .unlock:
            lockImageView.isHidden = true
        }
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(messageLabel)
        
        self.addSubview(backView)
        self.addSubview(lineView)
        self.addSubview(stackView)
        
        // Stackview autoLayout
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -self.bounds.height / 16).isActive = true
    }
}
