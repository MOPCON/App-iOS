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
    
    static func facebookButton() -> UIButton {
        
        let button = UIButton()
        
        button.setTitle("", for: .normal)
        
        return button
    }
}
