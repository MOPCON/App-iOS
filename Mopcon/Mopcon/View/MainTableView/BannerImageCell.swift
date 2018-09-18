//
//  BannerImageCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class BannerImageCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView! {
        didSet {
            bannerImageView.contentMode = .scaleAspectFit
            bannerImageView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func updateUI(url:URL){
        self.bannerImageView.kf.setImage(with: url)
    }
}
