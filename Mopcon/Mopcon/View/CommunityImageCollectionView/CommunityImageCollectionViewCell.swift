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
    
    func updateUI(image: String, title: String){
        
        communityLabel.text = title
        
        communityImageView.loadImage(image)
    }

    func updateUI(image: UIImage?, title: String){
        
        communityLabel.text = title
        
        communityImageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        communityImageView.makeCircle()
    }
    
}
