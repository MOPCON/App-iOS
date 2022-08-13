//
//  SpeakerAvatarView.swift
//  Mopcon
//
//  Created by Howard on 2022/7/31.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import UIKit

class SpeakerAvatarView: UIView {
    
    let bgImageView = UIImageView.init()
    let headImageView = UIImageView.init()
    let shadowImageView = UIImageView.init()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.shadowImageView)
        self.addSubview(self.bgImageView)
        self.addSubview(self.headImageView)
        
        self.shadowImageView.contentMode = .scaleAspectFill
        self.shadowImageView.image = UIImage.asset(.shadowImage)
        
        self.bgImageView.contentMode = .scaleAspectFill
        self.bgImageView.image = UIImage.asset(.bgImage)
        
        self.headImageView.contentMode = .scaleAspectFit
        
//        self.headImageView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(self.shadowImageView)
        self.addSubview(self.bgImageView)
        self.addSubview(self.headImageView)
        
        self.shadowImageView.contentMode = .scaleAspectFill
        self.shadowImageView.image = UIImage.asset(.shadowImage)
        
        self.bgImageView.contentMode = .scaleAspectFill
        self.bgImageView.image = UIImage.asset(.bgImage)
        
        self.headImageView.contentMode = .scaleAspectFit
        
//        self.headImageView.isHidden = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        self.headImageView.frame = CGRect(x: (self.bounds.size.width-100)/2-3, y: (self.bounds.size.height-100)/2-3.5, width: 100, height: 100)
        self.shadowImageView.frame = self.bounds
        self.bgImageView.frame = self.bounds
    }
    
    func loadImage(_ url: String)
    {
        self.headImageView.loadImage(url)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
