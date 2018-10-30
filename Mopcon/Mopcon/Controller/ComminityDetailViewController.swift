//
//  ComminityDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ComminityDetailViewController: UIViewController {
    
    var community: Community.Payload?
    
    @IBOutlet weak var communityDetailImageView: UIImageView!
    @IBOutlet weak var communityNameLabel: UILabel!
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var otherLinkButton: UIButton!
    
    
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if let community = community {
            updateUI(community: community)
            if community.facebook == "" {
                facebookButton.isHidden = true
            }
            if community.other_links == "" {
                otherLinkButton.isHidden = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Community"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
