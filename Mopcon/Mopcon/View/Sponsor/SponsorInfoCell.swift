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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(logo: String, company: String) {
        
        logoImageView.loadImage(logo)
        
        companyLabel.text = company
    }
}
