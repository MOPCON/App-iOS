//
//  SponsorDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum SponsorCellStyle: Int {
    case sponsor
    case info
    case seeMore
}

class SponsorDetailViewController: UIViewController {
    
    var sponsor: Sponsor.Payload?
    
    @IBOutlet weak var sponsorsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        sponsorsTableView.dataSource = self
        sponsorsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Sponsor"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showMore() {
        if let sponsor = sponsor,let url = URL(string: sponsor.website) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

extension SponsorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellidentifer = ""
        
        
        switch indexPath.row {
        case SponsorCellStyle.sponsor.rawValue:
            cellidentifer = SponsorTableViewCellID.sponsorCell
        case SponsorCellStyle.info.rawValue:
            cellidentifer = SponsorTableViewCellID.sponsorInfoCell
        default:
            cellidentifer = SponsorTableViewCellID.seeMoreCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifer, for: indexPath)
        if let sponsor = sponsor {
            // Get sponsor Data
            if let sponsorImageView = cell.viewWithTag(3) as? UIImageView {
                if let url = URL(string: sponsor.logo) {
                    sponsorImageView.kf.setImage(with: url)
                }
            }
            
            if let sponsorNameLabel = cell.viewWithTag(1) as? UILabel {
                sponsorNameLabel.text = sponsor.name
            }
            
            if let sponsorInfoLabel = cell.viewWithTag(2) as? UILabel {
                sponsorInfoLabel.text = sponsor.info
            }
            
            if let seeMoreButton = cell.viewWithTag(3) as? UIButton {
                seeMoreButton.addTarget(self, action: #selector(showMore), for: .touchUpInside)
            }

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 244
        case 1:
            return UITableViewAutomaticDimension
        default:
            return 70
        }
    }
    
    
}
