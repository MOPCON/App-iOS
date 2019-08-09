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
    
    func updateUI(sponsor:Sponsor.Payload){
        
        sponsorImageView.makeCircle()
        
        sponsorLabel.text = (CurrentLanguage.getLanguage() == Language.english.rawValue) ? sponsor.name_en : sponsor.name
        
        if let url = URL(string: sponsor.logo) {
            
            sponsorImageView.kf.setImage(with: url)
        }
    }
}
