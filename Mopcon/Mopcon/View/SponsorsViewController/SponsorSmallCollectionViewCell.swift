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
        
        sponsorImageView.makeCircle()
    }
    
    func updateUI(sponsor: Sponsor){
        
        sponsorLabel.text =
            (CurrentLanguage.getLanguage() == Language.english.rawValue)
            ? sponsor.nameEn
            : sponsor.name
        
        sponsorImageView.loadImage(sponsor.logo)
    }

}
