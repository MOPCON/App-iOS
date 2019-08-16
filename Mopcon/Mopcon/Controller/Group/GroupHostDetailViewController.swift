//
//  ComminityDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class GroupHostDetailViewController: UIViewController {
    
    var community: Community.Payload?
    
    @IBOutlet weak var communityDetailImageView: UIImageView!
    @IBOutlet weak var communityNameLabel: UILabel!
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    
    
    @IBAction func connectToFacebook(_ sender: UIButton) {
        if let community = community, let url = URL(string: community.facebook) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func otherLink(_ sender: UIButton) {
        if let community = community, let url = URL(string: community.other_links) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        if let community = community {
            updateUI(community: community)
            if community.facebook == "" {
                facebookButton.isHidden = true
            }
        }
        
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
    
    func updateUI(community:Community.Payload) {
        
        if let url = URL(string: community.logo) {
            communityDetailImageView.kf.setImage(with: url, options: [.forceRefresh])
        }
        communityNameLabel.text = community.title
        communityDescriptionLabel.text = community.info
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            communityDescriptionLabel.text = community.info
        case Language.english.rawValue:
            communityDescriptionLabel.text = community.info_en
        default:
            break
        }
        
    }

}
