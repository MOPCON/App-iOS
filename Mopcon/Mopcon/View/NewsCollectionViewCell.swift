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
    
    func updateUI(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
}
