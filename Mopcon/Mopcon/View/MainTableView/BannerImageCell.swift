//
//  BannerImageCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class BannerImageCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    func updateUI(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
