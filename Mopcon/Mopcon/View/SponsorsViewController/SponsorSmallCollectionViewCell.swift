//
//  SponsorCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SponsorSmallCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    func updateUI(sponsor:Sponsor.Payload){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        if let url = URL(string: sponsor.logo) {
            sponsorImageView.kf.setImage(with: url)
        }
    }
}
