//
//  JoinVolunteerView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol JoinVolunteerViewDelegate: AnyObject {
    
    func didTouchFacebookButton(_ volunteerView: JoinVolunteerView)
}

class JoinVolunteerView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    weak var delegate: JoinVolunteerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed(JoinVolunteerView.identifier, owner: self, options: nil)
    
        addAndStickSubView(contentView)
        
        facebookBtn.addTarget(self, action: #selector(openFacebook(_:)), for: .touchUpInside)
        
        facebookBtn.layer.cornerRadius = 6
        
        facebookBtn.layer.borderColor = UIColor.pink?.cgColor
        
        facebookBtn.layer.borderWidth = 1.0
        
        clipsToBounds = true
    }

    @objc func openFacebook(_ sender: UIButton) {
        
        delegate?.didTouchFacebookButton(self)
    }
}
