//
//  SponsorDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

private enum SponsorCellStyle {
    
    case sponsor(String, String, String, String), info(String), speech([SponsorSpeaker]), seeMore(String)
    

    
    func identifier() -> String {

        switch self {
            
        case .sponsor: return SponsorInfoCell.identifier
            
        case .info: return SponsorAboutCell.identifier
            
        case .speech: return ConferenceTableViewCell.identifier
            
        case .seeMore: return "SeeMoreCell"
            
        }
    }
    
    func manipulateCell(_ cell: UITableViewCell, controller: SponsorDetailViewController) {
        
        switch self {
            
        case .sponsor(let logo, let company, let webSite, let fbSite):
            
            guard let infoCell = cell as? SponsorInfoCell else { return }
            
            infoCell.updateUI(logo: logo, company: company, webSite: webSite, fbSite: fbSite)
            
        case .info(let info):
            
            guard let aboutCell = cell as? SponsorAboutCell else { return }
            
            aboutCell.updateUI(info: info)
            
        case .speech(let speakers):
            
            guard let conferenceTableViewCell = cell as? ConferenceTableViewCell else { return }
            
    
            conferenceTableViewCell.updateUI(sponsorSpeaker: speakers[0])

            
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
                
                cells.append(.sponsor(sponsor.logo.mobile, sponsor.name, sponsor.officialWebsite, sponsor.facebook))
                cells.append(.info(sponsor.aboutUs))
                
                for sponsorSpeaker in sponsor.speakerInfo
                {
                    cells.append(.speech([sponsorSpeaker]))
                }
                
//                cells.append(.seeMore(sponsor.officialWebsite))
           
            } else {
                
                cells = [
                    .sponsor(sponsor.logo.mobile, sponsor.name, sponsor.officialWebsite, sponsor.facebook),
                    .info(sponsor.aboutUs),
//                    .seeMore(sponsor.officialWebsite)
                ]
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    private func setupTableView() {
        
        sponsorsTableView.registerNib(identifier: ConferenceTableViewCell.identifier)
    }
    
    private var cells: [SponsorCellStyle] = []
    
    @IBAction func showMore() {
        
        openURL(sponsor?.officialWebsite)
    }
    
    
    @IBAction func onClickWebSiteButton(_ sender: Any) {
        openURL(sponsor?.officialWebsite)
    }
    
    
    @IBAction func onClickFbButton(_ sender: Any) {
        openURL(sponsor?.facebook)
    }
}

extension SponsorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==2)
        {
            return 20
        }
        else
        {
            return 5
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cells[indexPath.section].identifier(),
            for: indexPath
        )
        
        if let conferenceTableViewCell = cell as? ConferenceTableViewCell
        {
            conferenceTableViewCell.delegate = self
        }
        
        cells[indexPath.section].manipulateCell(cell, controller: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let sponsorImageView = cell.viewWithTag(3) as? UIImageView {
        
            sponsorImageView.layoutIfNeeded()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cells[indexPath.section]
        {
        case .sponsor: break
            
        case .info: break
            
        case .speech(let speakers):
            didTouchTalkInfoCell(speakers[0].sessionId)
        case .seeMore: break
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
                        
                    case .failure(let error):
                        
                        print(error)
                        
                    }
                    
                    self?.spinner.stopAnimating()
                }
            })
            
        } else {
            
            FavoriteManager.shared.removeSession(id: sessionId)
        }
    }
    
    func didTouchTalkInfoCell(_ sessionID: Int) {
        let agendaStoryboard = UIStoryboard(
            name: "Agenda",
            bundle: nil
        )
        
        if #available(iOS 13.0, *) {
            
            guard let detailVC = agendaStoryboard.instantiateViewController(
                identifier: ConferenceDetailViewController.identifier
            ) as? ConferenceDetailViewController else {
                
                return
            }
            
            detailVC.conferenceType = .session(sessionID)
            
            show(detailVC, sender: nil)
            
        } else {
            
            guard let detailVC = agendaStoryboard.instantiateViewController(
                withIdentifier: ConferenceDetailViewController.identifier
            ) as? ConferenceDetailViewController else {
                    
                return
            }
            
            detailVC.conferenceType = .session(sessionID)
            
            show(detailVC, sender: nil)
        }
    }
}

extension SponsorDetailViewController : ConferenceTableViewCellDelegate{
    
    func likeButtonDidTouched(_ cell: ConferenceTableViewCell)
    {
        guard let indexPath = sponsorsTableView.indexPath(for: cell) else { return }
        
        switch cells[indexPath.section] {
            
        case .sponsor: break
     
        case .info: break
            
        case .speech(let speakers):
            let isLiked = cell.addToMyScheduleButton.isSelected
            
            
            if isLiked {
                
                spinner.startAnimating()
                
                SessionProvider.fetchSession(id: speakers[0].sessionId, completion: { [weak self] result in
                    
                    self?.throwToMainThreadAsync {
                        
                        switch result {
                            
                        case .success(let room): FavoriteManager.shared.addSession(room: room)
                            
                        case .failure(let error):
                            
                            print(error)
                            
                        }
                        
                        self?.spinner.stopAnimating()
                    }
                })
                
            } else {
                
                FavoriteManager.shared.removeSession(id: speakers[0].sessionId)
            }
        case .seeMore: break
            
        }
        
        
        
    }
}

