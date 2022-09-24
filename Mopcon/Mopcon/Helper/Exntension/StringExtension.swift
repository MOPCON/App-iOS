//
//  StringExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/15.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    static let empty = ""
        
    func base64ToImage() -> UIImage? {
        
        if let data = Data(base64Encoded: self), let image = UIImage(data: data) {
            
            return image
        }
            
        return nil
    }
}
