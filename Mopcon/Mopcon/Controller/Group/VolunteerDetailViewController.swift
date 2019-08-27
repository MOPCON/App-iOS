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
    
    @IBOutlet weak var memberLbl: UILabel!
    
    var volunteerId: String? {
        
        didSet {
            
            guard let id = volunteerId else { return }
            
            fetchVolunteer(id: id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        volunteerImgView.image = nil
        
        volunteerTitleLbl.text = ""
        
        volunteerDetailLbl.text = ""
        
        volunteerListLbl.text = ""
        
        memberLbl.alpha = 0.0
    }
    
    func fetchVolunteer(id: String) {
        
        GroupProvider.fetchVolunteer(id: id, completion: { [weak self] result in
            
            switch result{
                
            case .success(let volunteer):
                
                self?.volunteerImgView.image = self?.image(name: volunteer.name)
                
                self?.volunteerTitleLbl.text = volunteer.name
                
                self?.volunteerDetailLbl.text = volunteer.introduction
                
                self?.volunteerListLbl.text = volunteer.members.joined(separator: ", ")
                
                self?.memberLbl.alpha = 1.0
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    func image(name: String) -> UIImage? {
        
        switch name {
            
        case "議程委員會": return UIImage.asset(.committee_team)
            
        case "行政組": return UIImage.asset(.administrative_team)
            
        case "議程組": return UIImage.asset(.agenda_team)
            
        case "財務組": return UIImage.asset(.finance_team)
            
        case "贊助組": return UIImage.asset(.sponsor_team)
            
        case "公關組": return UIImage.asset(.public_team)
            
        case "資訊組": return UIImage.asset(.into_team)
            
        case "美術組": return UIImage.asset(.art_team)
            
        case "紀錄組": return UIImage.asset(.record_team)
            
        case "攝影組": return UIImage.asset(.record_team)
            
        case "錄影組": return UIImage.asset(.video_team)
            
        case "場務組": return UIImage.asset(.place_team)
            
        default: return nil
            
        }
    }
}
