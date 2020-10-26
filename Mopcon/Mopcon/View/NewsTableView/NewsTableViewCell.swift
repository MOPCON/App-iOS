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
  

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        opacityView.layer.borderColor = UIColor.secondThemeColor?.cgColor
        dateLabel.textColor = UIColor.secondThemeColor
        timeLabel.textColor = UIColor.secondThemeColor
    }

    func updateUI(news: News) {
        
        dateLabel.text = DateFormatter.string(for: news.date, formatter: "yyyy/MM/dd")
        timeLabel.text = DateFormatter.string(for: news.date, formatter: "HH:mm")
        titleLabel.text = news.title
        dedcriptionLabel.text = news.description
    }
}
