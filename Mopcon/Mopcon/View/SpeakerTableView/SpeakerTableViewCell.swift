//
//  SpeakerTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var speakerAvatarImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerCompanyLabel: UILabel!
    

    func updateUI(){
        speakerAvatarImageView.image = UIImage(named: "s1")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }

}
