//
//  NewsTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol ButtonDidTappedDelegate {
    func messageConnectionButtonDidTapped(index:IndexPath)
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dedcriptionLabel: UILabel!
  
//    var delegate:ButtonDidTappedDelegate?
    var news:News.Payload?
    var index:IndexPath?
    
    @IBAction func messageConnectAction(_ sender: UIButton) {
//        print("OK")
//        delegate?.messageConnectionButtonDidTapped(index: index!)
        if let news = news, let url = URL(string: news.link) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func updateUI(news: News.Payload) {
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            timeLabel.text = news.time
            titleLabel.text = news.title
            dedcriptionLabel.text = news.description
        case Language.english.rawValue:
            timeLabel.text = news.time
            titleLabel.text = news.title
            dedcriptionLabel.text = news.description
        default:
            break
        }
    }
}
