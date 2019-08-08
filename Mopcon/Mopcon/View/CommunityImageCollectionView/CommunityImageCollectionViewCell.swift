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
    
    @IBOutlet weak var communityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
    }
    
    func updateUI(community: Community.Payload){
        
        if let url = URL(string: community.logo) {
            communityImageView.kf.setImage(with: url)
        }
        
        communityLabel.text = community.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        communityImageView.makeCircle()
    }
    
}
