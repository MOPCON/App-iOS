//
//  MissionCollectionViewCell.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/5.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

enum QuizStatus: String {
    case fail = "-1" // 任務失敗
//    case lock = "0" // 尚未解鎖
    case unlock = "1" // 解鎖任務
    case success = "2" // 任務成功
}

class MissionCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
        self.clipsToBounds = true
    }
    
    func updateUI(item: Quiz) {
        typeLabel.text = item.type
        titleLabel.text = item.title
        
        switch item.status {
        case QuizStatus.success.rawValue:
            completedView.isHidden = false
            resultImageView.image = UIImage(named: "iconSucess")
            resultLabel.text = "挑戰成功"
            resultLabel.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        case QuizStatus.fail.rawValue:
            completedView.isHidden = false
            resultImageView.image = UIImage(named: "iconFailed")
            resultLabel.text = "挑戰失敗"
            resultLabel.textColor = #colorLiteral(red: 0.8196078431, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        default:
            completedView.isHidden = true
        }
    }
}
