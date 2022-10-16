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
        
        seperatorView.frame = CGRect(x: 0, y: (bounds.size.height / 2) - 1, width: bounds.size.width, height: 1)
        
        button.sizeToFit()
        
        let width = UIScreen.main.bounds.width * (130 / 375)
        
        let height = 37.0
        
        button.frame = CGRect(x: (bounds.size.width - width) / 2, y: (bounds.size.height - height) / 2, width: width, height: height)
        
        button.layer.cornerRadius = button.frame.size.height / 2
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Private method

    private func setupButton(buttonTitle:String, titleColor:UIColor) {
        
        button.backgroundColor = UIColor.mainThemeColor
        
        button.setTitle(buttonTitle, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        button.setTitleColor(UIColor.textGray, for: .normal)
        
        button.setTitleColor(.white, for: .selected)
                
        addSubview(button)
    }
    
    
    private func setupSeperatorView() {
        
        seperatorView.backgroundColor = UIColor.pink
        
        addSubview(seperatorView)
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
