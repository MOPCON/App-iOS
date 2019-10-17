//
//  UIViewExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/19.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
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
    
    func applyGradient(colours: [UIColor]) -> Void {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = self.bounds
        
        gradient.colors = colours.map { $0.cgColor }
        
        gradient.locations = [0,1]
        
        self.layer.addSublayer(gradient)
    }
}
