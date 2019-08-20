//
//  PresentCell.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/8/16.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class PresentCell: UITableViewCell {

    @IBOutlet weak var presentImageView: UIImageView!
    
    @IBOutlet weak var presentNameLabel: UILabel!
    
    @IBOutlet weak var presentDescriptionLabel: UILabel!
    
    @IBOutlet weak var getButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        presentImageView.makeCircle()
    }

    
}
