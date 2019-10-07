//
//  SponsorDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

private enum SponsorCellStyle {
    
    case sponsor(String, String), info(String), speech([SponsorSpeaker]), seeMore(String)
    
    func identifier() -> String {

        switch self {
            
        case .sponsor: return SponsorInfoCell.identifier
            
        case .info: return SponsorAboutCell.identifier
            
        case .speech: return SponsorSpeechCell.identifier
            
        case .seeMore: return "SeeMoreCell"
            
        }
    }
    
    func manipulateCell(_ cell: UITableViewCell, controller: SponsorDetailViewController) {
        
        switch self {
            
        case .sponsor(let logo, let company):
            
            guard let infoCell = cell as? SponsorInfoCell else { return }
            
            infoCell.updateUI(logo: logo, company: company)
            
        case .info(let info):
            
            guard let aboutCell = cell as? SponsorAboutCell else { return }
            
            aboutCell.updateUI(info: info)
            
        case .speech(let speakers):
            
            guard let speechCell = cell as? SponsorSpeechCell else { return }
            
            speechCell.sponsorSpeaker = speakers
            
            speechCell.delegate = controller
            
        case .seeMore: break
            
        }
    }
}

class SponsorDetailViewController: MPBaseViewController {
    
    @IBOutlet weak var sponsorsTableView: UITableView!
    
    let spinner = LoadingTool.setActivityindicator()
    
    var sponsor: Sponsor? {
        
        didSet {
            
            guard let sponsor = sponsor else {
                
                cells = []
                
                return
            }
        
            if sponsor.speakerInfo.count > 0 {
                
                cells = [
                    .sponsor(sponsor.logo, sponsor.name),
                    .info(sponsor.aboutUs),
                    .speech(sponsor.speakerInfo),
                    .seeMore(sponsor.officialWebsite)
                ]
                
            } else {
                
                cells = [
                    .sponsor(sponsor.logo, sponsor.name),
                    .info(sponsor.aboutUs),
                    .seeMore(sponsor.officialWebsite)
                ]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private var cells: [SponsorCellStyle] = []
    
    @IBAction func showMore() {
        
        openURL(sponsor?.officialWebsite)
    }
}

extension SponsorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cells[indexPath.row].identifier(),
            for: indexPath
        )
        
        cells[indexPath.row].manipulateCell(cell, controller: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let sponsorImageView = cell.viewWithTag(3) as? UIImageView {
        
            sponsorImageView.layoutIfNeeded()
            
            sponsorImageView.makeCircle()
        }
    }
}

extension SponsorDetailViewController: SponsorSpeechCellDelegate {
    
    func likeButtonDidTouched(_ cell: SponsorSpeechCell, sessionId: Int, isLiked: Bool) {
        
        if isLiked {
            
            spinner.startAnimating()
            
            SessionProvider.fetchSession(id: sessionId, completion: { [weak self] result in
                
                self?.throwToMainThreadAsync {
                    
                    switch result {
                        
                    case .success(let room): FavoriteManager.shared.addSession(room: room)
                        
                    case .failure(let error): print(error)
                        
                    }
                    
                    self?.spinner.stopAnimating()
                }
            })
            
        } else {
            
            FavoriteManager.shared.removeSession(id: sessionId)
        }
    }
}
