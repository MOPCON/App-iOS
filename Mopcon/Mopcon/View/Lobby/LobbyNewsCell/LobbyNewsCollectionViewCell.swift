//
//  LobbyNewsCollectionViewCell.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2022/8/23.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import UIKit

class LobbyNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setup()
    }

    func setup() {

        layer.borderColor = UIColor.pink?.cgColor

        layer.borderWidth = 1.0

        layer.cornerRadius = 10.0
    }
    
    func updateUI(_ news: HomeNews) {
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: Date(timeIntervalSince1970: TimeInterval(news.date)))
        
        titleLabel.text = news.title
        
        dateLabel.text = "\(DateFormatter.string(for: news.date, formatter: "MM/dd") ?? "")(\(weekday.makeWeekday()))"
        
        descriptionLabel.text = news.description
    }
}
