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
        
        opacityView.layer.borderColor = UIColor.pink?.cgColor
        
        dateLabel.textColor = UIColor.pink
        
        timeLabel.textColor = UIColor.pink
    }

    func updateUI(news: News) {
        
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: Date(timeIntervalSince1970: TimeInterval(news.date)))
        
        dateLabel.text = "\(DateFormatter.string(for: news.date, formatter: "MM/dd") ?? "")(\(weekday.makeWeekday()))"
        
        timeLabel.text = DateFormatter.string(for: news.date, formatter: "HH:mm")
        
        titleLabel.text = news.title
        
        dedcriptionLabel.text = news.description
    }
}
