//
//  GridCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/1.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateUI(imageName:String,title:String){
        iconImageView.image = UIImage(named: imageName)
        titleLabel.text = title
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
}
