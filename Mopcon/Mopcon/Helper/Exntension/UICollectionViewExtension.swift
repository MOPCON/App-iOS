//
//  UICollectionViewExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

import UIKit

extension UICollectionView {
    
    func registerNib(identifier: String) {
        
        let nib = UINib(nibName: identifier, bundle: nil)
        
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
