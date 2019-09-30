//
//  ButtonFactor.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/27.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

enum SocialButtonType {
    
    case facebook(String)
    
    case twitter(String)
    
    case github(String)
    
    case website(String)
}

class ButtonFactor {
    
    static private func button(asset: ImageAsset) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle("", for: .normal)
        
        button.backgroundColor = UIColor.clear
        
        button.setBackgroundImage(UIImage.asset(asset), for: .normal)
        
        return button
    }
    
    static func facebookButton() -> UIButton {
        
        return button(asset: .iconFB)
    }
    
    static func githubButton() -> UIButton {
        
        return button(asset: .iconGithub)
    }
    
    static func twitterButton() -> UIButton {
        
        return button(asset: .iconTwitter)
    }
}
