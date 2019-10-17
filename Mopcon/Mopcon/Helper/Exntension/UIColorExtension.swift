//
//  UIColorExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let azure = UIColor(hex: "#00aaf0")
    
    static let dark = UIColor(hex: "#101721")
    
    static let almostBlack = UIColor(hex: "#070b11", alpha: 0.2)
    
    static let pink = UIColor(hex: "#ff4392")
    
    static let barbiePink = UIColor(hex: "#ff4492")
    
    static let azureTwo = UIColor(hex: "#01aaf0")
    
    static let greenTwo = UIColor(hex: "#98ce02")
    
    static let brownGray = UIColor(hex: "#878787")
    
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return nil
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

