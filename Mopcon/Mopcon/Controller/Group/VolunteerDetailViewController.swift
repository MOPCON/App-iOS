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
    
    @IBOutlet weak var emptyView: UIView!
    
    var volunteerId: String? {
        
        didSet {
            
            guard let id = volunteerId else { return }
            
            fetchVolunteer(id: id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyView.backgroundColor = UIColor.dark
        
        emptyView.isHidden = false
    }
    
    func fetchVolunteer(id: String) {
        
        GroupProvider.fetchVolunteer(id: id, completion: { [weak self] result in
            
            switch result{
                
            case .success(let volunteer):
                
                self?.volunteerImgView.loadImage(volunteer.photo)
                
                self?.volunteerTitleLbl.text = volunteer.name
                
                self?.volunteerDetailLbl.text = volunteer.introduction
                
                self?.volunteerListLbl.text = volunteer.members.joined(separator: ", ")
                
                self?.emptyView.isHidden = true
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}
