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
        
        self.commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commitInit()
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
       
        self.headImageView.frame = CGRect(x: (self.bounds.size.width-100)/2-1, y: (self.bounds.size.height-100)/2-1, width: 100, height: 100)

        self.bgImageView.frame = CGRect(x: (self.bounds.size.width-103)/2, y: (self.bounds.size.height-102)/2, width: 103, height: 102)
    }
    
    private func commitInit(){
        
        self.addSubview(self.bgImageView)
        
        self.addSubview(self.headImageView)

        self.bgImageView.contentMode = .scaleAspectFill
        self.bgImageView.image = UIImage.asset(.bgImage)
        
        self.headImageView.contentMode = .center
        self.headImageView.image = UIImage.asset(.defaultHead)
    }
    
    func loadImage(_ url: String) {
        
        if(url.count>0)
        {
            self.headImageView.loadImage(url)
            self.headImageView.contentMode = .scaleAspectFit
        }
    }
}
