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
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(community:Community.Payload) {
        
        if let url = URL(string: community.logo) {
            communityDetailImageView.kf.setImage(with: url)
        }
        communityNameLabel.text = community.title
        communityDescriptionLabel.text = community.info
    }

}
