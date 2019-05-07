//
//  CommunityImageCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunityImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var communityImageView: UIImageView!
    
    func updateUI(community:Community.Payload){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        if let url = URL(string: community.logo) {
            communityImageView.kf.setImage(with: url)
        }
    }
    
}
