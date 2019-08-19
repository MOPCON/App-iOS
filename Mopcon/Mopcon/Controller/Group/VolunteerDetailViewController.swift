//
//  VolunteerDetailViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/16.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class VolunteerDetailViewController: MPBaseViewController {

    @IBOutlet weak var volunteerImgView: UIImageView!
    
    @IBOutlet weak var volunteerTitleLbl: UILabel!
    
    @IBOutlet weak var volunteerDetailLbl: UILabel!
    
    @IBOutlet weak var volunteerListLbl: UILabel!
    
    var volunteer: Volunteer.Payload? {
        
        didSet {
        
            if volunteer != nil {
            
                volunteerImgView.image = volunteer?.image()
                
                volunteerTitleLbl.text = volunteer?.groupname
                
                volunteerDetailLbl.text = volunteer?.info
                
                volunteerListLbl.text = volunteer?.memberlist
            }
        }
    }
    
}
