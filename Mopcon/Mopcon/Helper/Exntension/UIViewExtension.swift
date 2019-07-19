//
//  UIViewExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/19.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

extension UIView {
    
    func addAndStickSubView(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subview)
        
        NSLayoutConstraint.activate([
            
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
