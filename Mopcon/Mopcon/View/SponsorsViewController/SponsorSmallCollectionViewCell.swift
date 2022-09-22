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
    
    @IBOutlet weak var sponsorLabel: UILabel!
    
    override func layoutSubviews() {
        
        sponsorImageView.makeCorner(radius: sponsorImageView.frame.size.height / 2)
    }
    
    func updateUI(sponsor: Sponsor){
        
        sponsorLabel.text =
            (CurrentLanguage.getLanguage() == Language.english.rawValue)
            ? sponsor.nameEn
            : sponsor.name
        
        sponsorImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        sponsorImageView.backgroundColor = .white
        
        sponsorImageView.loadImage(sponsor.logo.mobile)
    }

}
