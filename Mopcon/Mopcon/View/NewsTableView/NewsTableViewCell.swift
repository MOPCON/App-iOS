//
//  NewsTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dedcriptionLabel: UILabel!
  
    var news:News.Payload?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
        
        opacityView.layer.borderColor = UIColor.azure?.cgColor
    }

    func updateUI(news: News.Payload) {
        let timeData = news.time.components(separatedBy: " ")
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            dateLabel.text = timeData[0]
            timeLabel.text = timeData[1]
            titleLabel.text = news.title
            dedcriptionLabel.text = news.description
        case Language.english.rawValue:
            dateLabel.text = timeData[0]
            timeLabel.text = timeData[1]
            titleLabel.text = news.title
            dedcriptionLabel.text = news.description
        default:
            break
        }
    }
}
