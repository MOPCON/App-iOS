//
//  SponsorInfoCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/26.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class SponsorInfoCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var webButton: UIButton!
    
    @IBOutlet weak var fbButton: UIButton!
    
    @IBOutlet weak var webButtonCenterLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fbButtonCenterlayoutConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        logoImageView.contentMode = UIView.ContentMode.scaleAspectFit
        logoImageView.backgroundColor = UIColor.white
        
        webButton.setTitle("", for: UIControl.State.normal)
        webButton.setTitle("", for: UIControl.State.highlighted)
        fbButton.setTitle("", for: UIControl.State.normal)
        fbButton.setTitle("", for: UIControl.State.highlighted)
    }

    func updateUI(logo: String, company: String, webSite: String, fbSite: String) {
        
        logoImageView.loadImage(logo)
        logoImageView.makeCorner(radius: 20)
        
        companyLabel.text = company
        
        fbButton.isHidden = (fbSite.count<=0)
        webButton.isHidden = (webSite.count<=0)
        
        if(fbButton.isHidden==true && webButton.isHidden==false)
        {
            webButtonCenterLayoutConstraint.constant = 0
        }
        else if(fbButton.isHidden==false && webButton.isHidden==true)
        {
            fbButtonCenterlayoutConstraint.constant = 0
        }
    }
}
