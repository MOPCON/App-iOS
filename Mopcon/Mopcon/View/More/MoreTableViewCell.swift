//
//  MoreTableViewCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/6.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var avaterImageView: UIImageView!
    
    @IBOutlet weak var avaterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutCell(image: UIImage?, name: String) {
        
        avaterImageView.image = image
        
        avaterNameLabel.text = name
    }

}
