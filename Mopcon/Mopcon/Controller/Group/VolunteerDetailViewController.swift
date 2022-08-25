//
//  VolunteerDetailViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/16.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class VolunteerDetailViewController: MPBaseViewController {

    @IBOutlet weak var volunteerView: SpeakerAvatarView!
    
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
                
                self?.volunteerView.loadImage(volunteer.photo)
                
                self?.updateImageView()
                
                self?.volunteerTitleLbl.text = volunteer.name
                
                self?.volunteerDetailLbl.text = volunteer.introduction
                
                self?.volunteerListLbl.text = volunteer.members.joined(separator: ", ")
                
                self?.emptyView.isHidden = true
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    func updateImageView() {
        let coverImageView = UIImageView()

        self.volunteerView.addSubview(coverImageView)
        
        let coverImage = UIImage.asset(.coverImage)

        coverImageView.image = coverImage

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        coverImageView.contentMode = .scaleAspectFill

        self.volunteerView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: self.volunteerView, attribute: .width, multiplier: 1, constant: 0))

        self.volunteerView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: self.volunteerView, attribute: .height, multiplier: 1, constant: 0))

        self.volunteerView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .top, relatedBy: .equal, toItem: self.volunteerView, attribute: .top, multiplier: 1, constant: 0))

        self.volunteerView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .left, relatedBy: .equal, toItem: self.volunteerView, attribute: .left, multiplier: 1, constant: 0))
    }
}
