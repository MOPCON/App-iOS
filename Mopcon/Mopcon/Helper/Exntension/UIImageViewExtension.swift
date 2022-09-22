//
//  DownloadImage.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    
    // Make Circle Image
    func makeCircle() {
        self.layer.cornerRadius = self.frame.height / 2
        
        self.clipsToBounds = true
    }
    
    func makeCorner(radius:CGFloat)
    {
        self.layer.cornerRadius = radius
        
        self.clipsToBounds = true
    }
    
    
    func loadImage(_ url: String) {
        
        guard let url = URL(string: url) else { return }
        
        kf.setImage(with: url)
    }
}
