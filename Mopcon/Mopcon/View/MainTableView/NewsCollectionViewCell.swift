//
//  NewsCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/1.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
    
    func updateUI(news: News) {
        
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            self.titleLabel.text = "最新消息"
            self.descriptionLabel.text = news.title
        case Language.english.rawValue:
            self.titleLabel.text = "News"
            self.descriptionLabel.text = news.title
        default:
            break
        }
    }
}
