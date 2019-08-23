//
//  ComminityDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class GroupHostDetailViewController: UIViewController {
    
    var communityID: String?
    
    var organizer: Organizer?
    
    @IBOutlet weak var communityDetailImageView: UIImageView!
    
    @IBOutlet weak var communityNameLabel: UILabel!
    
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBAction func connectToFacebook(_ sender: UIButton) {
        
        if let organizer = organizer, let url = URL(string: organizer.facebook) {
        
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        facebookButton.layer.cornerRadius = 15
        
        facebookButton.layer.borderColor = UIColor.azure?.cgColor
        
        facebookButton.layer.borderWidth = 1.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        communityDetailImageView.makeCircle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Community"
        }
    }
    
    func fetchOrganizer() {
        
        guard let id = communityID else { return }
        
        GroupProvider.fetchOrganizer(
            id: id,
            completion: { [weak self] result in
            
                switch result{
                    
                case .success(let organizer):
                    
                    self?.updateUI(organizer: organizer)
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
    }
    
    func updateUI(organizer: Organizer) {

        communityDetailImageView.loadImage(organizer.photo)
        
        communityNameLabel.text = organizer.name
        
        let language = CurrentLanguage.getLanguage()
        
        switch language {
        
        case Language.chinese.rawValue:
        
            communityDescriptionLabel.text = organizer.introducion
        
        case Language.english.rawValue:
        
            communityDescriptionLabel.text = organizer.introducionEn
        
        default:
            
            break
        }
        
    }

}
