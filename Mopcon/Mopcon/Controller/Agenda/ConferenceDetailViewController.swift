//
//  ConferenceDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ConferenceDetailViewController: MPBaseViewController {
    
    var unconfId: Int?
    
    var sessionId: Int?
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    
    @IBOutlet weak var speakerName: UILabel!
    
    @IBOutlet weak var speakerJob: UILabel!
    
    @IBOutlet weak var scheduleInfoLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sponsorTitleLabel: UILabel!
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    @IBOutlet weak var sponsorLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func addToMySchedule(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
        
        fetchUnconfInfo()
        
        fetchSessionInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        speakerImageView.makeCircle()

        sponsorImageView.makeCircle()
    }
    
    //MARK: - API
    private func fetchUnconfInfo() {
        
        guard let id = unconfId else { return }
        
        UnconfProvider.fetchUnConfInfo(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let info):
                
                self?.throwToMainThreadAsync {
                    
                    self?.updateUI(room: info)
                    
                    self?.scrollView.isHidden = false
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    private func fetchSponsor(id: Int) {
        
        SponsorProvider.fetchSponsor(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let sponsors):
                
                self?.throwToMainThreadAsync {
                    
                    self?.updateUI(sponsors: sponsors)
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    private func fetchSessionInfo() {
        
        guard let id = sessionId else { return }
        
        SessionProvider.fetchSession(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let room):
                
                self?.throwToMainThreadAsync {
                    
                    self?.updateUI(room: room)
                    
                    self?.scrollView.isHidden = false
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    // MARK: - Layout View
    func updateUI(room: Room) {
        
        if let sponsor = room.sponsorInfo {
        
            sponsorImageView.isHidden = false
            
            sponsorTitleLabel.isHidden = false
            
            sponsorLabel.isHidden = false
            
            sponsorImageView.kf.setImage(with: URL(string: sponsor.logo))
            
            switch CurrentLanguage.getLanguage() {
                
            case Language.chinese.rawValue:
            
                sponsorLabel.text = sponsor.name
                
            case Language.english.rawValue:
            
                sponsorLabel.text = sponsor.nameEn
                
            default: break
                
            }
            
        } else {
            
            sponsorImageView.isHidden = true
            
            sponsorTitleLabel.isHidden = true
            
            sponsorLabel.isHidden = true
        }

        speakerImageView.kf.setImage(
            with: URL(string: room.speakers.first!.img.mobile),
            placeholder: UIImage.asset(.fieldGameProfile)
        )

        let language = CurrentLanguage.getLanguage()

        switch language {

        case Language.chinese.rawValue:

            scheduleInfoLabel.text = room.summary

            typeLabel.text = room.tags.reduce("", { $0 + $1.name + " "})

            topicLabel.text = room.topic

            speakerName.text = room.speakers.first?.name

            let job = "\(room.speakers.first?.jobTitle ?? "")@\(room.speakers.first?.company ?? "")"

            speakerJob.text = (job == "@") ? "" : job

        case Language.english.rawValue:

            scheduleInfoLabel.text = room.summaryEn

            typeLabel.text = room.tags.reduce("", { $0 + $1.name + " "})

            topicLabel.text = room.topicEn

            speakerName.text = room.speakers.first?.name

            let job = "\(room.speakers.first?.jobTitleEn ?? "")@\(room.speakers.first?.companyEn ?? "")"

            speakerJob.text = (job == "@") ? "" : job

        default:

            break
        }
    }
    
    func updateUI(sponsors: [Sponsor]) {
        
        guard let sponsor = sponsors.first else {
        
            return
        }
        
        sponsorImageView.isHidden = false
        
        sponsorTitleLabel.isHidden = false
        
        sponsorLabel.isHidden = false
        
        sponsorImageView.kf.setImage(with: URL(string: sponsor.logo))
        
        switch CurrentLanguage.getLanguage() {
            
        case Language.chinese.rawValue:
        
            sponsorLabel.text = sponsor.name
            
        case Language.english.rawValue:
        
            sponsorLabel.text = sponsor.nameEn
            
        default: break
        }
    }
}
