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
    case speech
    case seeMore
}

class SponsorDetailViewController: UIViewController {
    
    var sponsor: Sponsor.Payload?
    
    @IBOutlet weak var sponsorsTableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
        
            navigationItem.title = "Sponsor"
        }
    }
    
    private func setupTableView() {
        
        sponsorsTableView.dataSource = self
        
        sponsorsTableView.delegate = self
        
         let conferenceTableViewCell = UINib(nibName: String(describing: ConferenceTableViewCell.self), bundle: nil)
        
        sponsorsTableView.register(conferenceTableViewCell, forCellReuseIdentifier: AgendaTableViewCellID.conferenceCell)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /* should get data count from api */
        return (section == 2) ? 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellidentifer = ""
        
        switch indexPath.section {
            
        case SponsorCellStyle.sponsor.rawValue:
            
            cellidentifer = SponsorTableViewCellID.sponsorCell
            
        case SponsorCellStyle.info.rawValue:
            
            cellidentifer = SponsorTableViewCellID.sponsorInfoCell
        
        case SponsorCellStyle.speech.rawValue:
            
            cellidentifer = AgendaTableViewCellID.conferenceCell
            
        default:
            
            cellidentifer = SponsorTableViewCellID.seeMoreCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifer, for: indexPath)
        
        if indexPath.section == 2 {
            (cell as! ConferenceTableViewCell).leadingConstraint.constant = 20
            
            (cell as! ConferenceTableViewCell).trailingConstraint.constant = 20
//            (cell as! ConferenceTableViewCell).updateUI(agenda: )
            return cell
        }
        
        if let sponsor = sponsor {
            // Get sponsor Data
        
            if let sponsorImageView = cell.viewWithTag(3) as? UIImageView {
                
                if let url = URL(string: sponsor.logo) {
                
                    sponsorImageView.kf.setImage(with: url)
                }
            }
            
            if let sponsorNameLabel = cell.viewWithTag(1) as? UILabel {
        
                sponsorNameLabel.text = (CurrentLanguage.getLanguage() == Language.english.rawValue) ? sponsor.name_en : sponsor.name
            }
            
            if let sponsorInfoLabel = cell.viewWithTag(2) as? UILabel {
                
                sponsorInfoLabel.text = (CurrentLanguage.getLanguage() == Language.english.rawValue) ? sponsor.info_en : sponsor.info
            }
            
            if let seeMoreButton = cell.viewWithTag(4) as? UIButton {
                
                if sponsor.website == "" {
                
                    seeMoreButton.isHidden = true
                }
                
                seeMoreButton.addTarget(self, action: #selector(showMore), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let sponsorImageView = cell.viewWithTag(3) as? UIImageView {
        
            sponsorImageView.layoutIfNeeded()
            
            sponsorImageView.makeCircle()
        }
    }
    

}
