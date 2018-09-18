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
  
    var delegate:ButtonDidTappedDelegate?
    var index:IndexPath?
    
    @IBAction func messageConnectAction(_ sender: UIButton) {
        print("OK")
        delegate?.messageConnectionButtonDidTapped(index: index!)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func updateUI(news: News.Payload) {
        timeLabel.text = news.time
        titleLabel.text = news.title
        dedcriptionLabel.text = news.description
    }
}
