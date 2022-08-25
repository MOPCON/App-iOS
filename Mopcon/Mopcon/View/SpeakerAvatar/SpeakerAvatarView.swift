//
//  SpeakerAvatarView.swift
//  Mopcon
//
//  Created by Howard on 2022/7/31.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import UIKit

class SpeakerAvatarView: UIView {
    
    let bgImageView = UIImageView()
    
    let headImageView = UIImageView()
 
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        self.addSubview(self.bgImageView)
        
        self.addSubview(self.headImageView)

        self.bgImageView.contentMode = .scaleAspectFill
        
        self.bgImageView.image = UIImage.asset(.bgImage)
        
        self.headImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubview(self.bgImageView)
        
        self.addSubview(self.headImageView)
        
        self.bgImageView.contentMode = .scaleAspectFill
        
        self.bgImageView.image = UIImage.asset(.bgImage)
        
        self.headImageView.contentMode = .scaleAspectFit
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
       
        self.headImageView.frame = CGRect(x: (self.bounds.size.width-100)/2-1, y: (self.bounds.size.height-100)/2-1, width: 100, height: 100)

        self.bgImageView.frame = CGRect(x: (self.bounds.size.width-103)/2, y: (self.bounds.size.height-102)/2, width: 103, height: 102)
    }
    
    func loadImage(_ url: String) {
        
        self.headImageView.loadImage(url)
    }
}
