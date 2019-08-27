//
//  UIViewControllerExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}
