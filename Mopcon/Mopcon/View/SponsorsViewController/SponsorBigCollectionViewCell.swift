//
//  SponsorBigCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SponsorBigCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sponsorBigImageView: UIImageView!
    
    func updateUI(sponsor:Sponsor.Payload){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        if let url = URL(string: sponsor.logo) {
            sponsorBigImageView.kf.setImage(with: url)
        }
    }
}
