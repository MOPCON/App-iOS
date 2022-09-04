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

    @IBOutlet weak var sponsorLabelHeightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        
        sponsorImageView.makeCorner(radius: 20)
    }
    
    func updateUI(sponsor: Sponsor){
        
        sponsorLabel.text =
            (CurrentLanguage.getLanguage() == Language.english.rawValue)
            ? sponsor.nameEn
            : sponsor.name
        
        sponsorImageView.contentMode = UIView.ContentMode.scaleAspectFit
        sponsorImageView.backgroundColor = UIColor.white
        sponsorImageView.loadImage(sponsor.logo.mobile)
        
        sponsorLabel.numberOfLines = 0
        
        let labelSize = sponsorLabel.sizeThatFits(CGSize(width: self.sponsorLabel.bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        
        self.sponsorLabelHeightConstraint.constant =  max(19.5,labelSize.height)
        
        print(sponsorLabel.text!,self.sponsorLabelHeightConstraint.constant)
    }

}
