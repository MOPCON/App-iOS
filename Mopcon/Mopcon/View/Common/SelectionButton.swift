//
//  SelectionButton.swift
//  Mopcon
//
//  Created by 林紘毅 on 2022/8/24.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import Foundation
import UIKit

class SelectionButton: UIView {
    
    let button = UIButton()
    
    private let seperatorView = UIView()
    
    required init(buttonTitle:String, titleColor:UIColor)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setupSeperatorView()
        setupButton(buttonTitle: buttonTitle, titleColor: titleColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.seperatorView.frame = CGRect(x: 0, y: self.bounds.size.height/2-1, width: self.bounds.size.width, height: 2)
        
        self.button.sizeToFit()
        
        let width = self.button.frame.size.width + 60
        let height = ceil(width/160*37)
        
        self.button.frame = CGRect(x: (self.bounds.size.width-width)/2, y: (self.bounds.size.height-height)/2, width: width, height: height)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Private method

    private func setupButton(buttonTitle:String, titleColor:UIColor) {
        
        button.backgroundColor = UIColor.mainThemeColor
        button.layer.cornerRadius = 15

        button.setTitle(buttonTitle, for: .normal)

        button.setTitleColor(titleColor, for: .normal)
        
        self.addSubview(button)
    }
    
    
    private func setupSeperatorView() {
        
        self.seperatorView.backgroundColor = UIColor.pink
        self.addSubview(self.seperatorView)
    }
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Instance method

    public func selected()
    {
        button.backgroundColor = UIColor.pink
    }
    
    public func unselected()
    {
        button.backgroundColor = UIColor.mainThemeColor
    }
}
