//
//  CommunityImageCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunityImageCollectionViewCell: UICollectionViewCell {
    
    func updateUI(imageName:String){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        communityImageView.image = UIImage(named: imageName)
    }
    @IBOutlet weak var communityImageView: UIImageView!
}
