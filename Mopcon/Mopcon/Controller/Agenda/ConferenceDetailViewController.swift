//
//  ConferenceDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ConferenceDetailViewController: MPBaseViewController {
    
    var id: Int?
    
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        speakerImageView.makeCircle()

        sponsorImageView.makeCircle()
    }
    
    //MARK: - API
    
    private func fetchUnconfInfo() {
        
        guard let id = id else { return }
        
        UnconfProvider.fetchUnConfInfo(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let info):
                
                self?.throwToMainThreadAsync {
                    
                    self?.updateUI(info: info)
                    
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
                
                print(sponsors)
                
                self?.throwToMainThreadAsync {
                    
                    self?.updateUI(sponsors: sponsors)
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    // MARK: - Layout View
    func updateUI(info: SessionInfo) {
        
        if info.sponsorID == 0 {
            
            sponsorImageView.isHidden = true
            
            sponsorTitleLabel.isHidden = true
            
            sponsorLabel.isHidden = true
            
            scheduleInfoLabel.isHidden = true
            
        } else {
            
            fetchSponsor(id: info.sponsorID)
        }
        
        if let picture = info.speakers.first?.img.mobile {
        
            speakerImageView.kf.setImage(
                with: URL(string: picture),
                placeholder: UIImage.asset(.fieldGameProfile)
            )
        }

        let language = CurrentLanguage.getLanguage()
        
        switch language {
        
        case Language.chinese.rawValue:
        
            scheduleInfoLabel.text = info.summary
            
            typeLabel.text = info.tags.reduce("", { $0 + $1.name + " "})
            
            topicLabel.text = info.topic
            
            speakerName.text = info.speakers.first?.name
            
            let job = "\(info.speakers.first?.jobTitle ?? "")@\(info.speakers.first?.company ?? "")"
            
            speakerJob.text = (job == "@") ? "" : job
        
        case Language.english.rawValue:
        
            scheduleInfoLabel.text = info.summaryEn
            
            typeLabel.text = info.tags.reduce("", { $0 + $1.name + " "})
            
            topicLabel.text = info.topicEn
            
            speakerName.text = info.speakers.first?.name
            
            let job = "\(info.speakers.first?.jobTitleEn ?? "")@\(info.speakers.first?.companyEn ?? "")"
            
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
        
        scheduleInfoLabel.isHidden = false
        
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
