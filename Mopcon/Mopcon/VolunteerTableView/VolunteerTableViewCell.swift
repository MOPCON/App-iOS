//
//  VolunteerTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class VolunteerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var volunteerOrganizationTitleLabel: UILabel!
    @IBOutlet weak var volunteerDescriptionLabel: UILabel!
    @IBOutlet weak var volunteerMembersLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func updateUI(volunteer:Volunteer.Payload) {
        volunteerOrganizationTitleLabel.text = volunteer.groupname
        volunteerDescriptionLabel.text = volunteer.info
        volunteerMembersLabel.text = volunteer.memberlist
    }

}
