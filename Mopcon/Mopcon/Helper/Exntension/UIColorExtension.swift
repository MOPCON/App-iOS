//
//  UIColorExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let mainThemeColor = UIColor(hex: "#022b42")
    
    static let secondThemeColor = UIColor(hex: "#51a3d3")
    
    static let tabbarSelectedColor = UIColor(hex: "#ff7987")
    
    static let navigationBottomBorderColor = UIColor(hex: "#00aaf0")
    
    static let dark = UIColor(hex: "#022b42")
    
    static let tagTextColor = UIColor.white
        
    static let tagBackgroundColor = UIColor(hex: "#51a3d3")
        
    static let pink = UIColor(hex: "#ff7987")
    
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

