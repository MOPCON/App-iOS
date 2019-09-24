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
    
    @IBAction func addToMySchedule(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUnconfInfo()
    }
    
    private func fetchUnconfInfo() {
        
        guard let id = id else { return }
        
        UnconfProvider.fetchUnConfInfo(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let info):
                
                self?.throwToMainThreadAsync {
                    
                    self?.updateUI(info: info)
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        speakerImageView.makeCircle()

        sponsorImageView.makeCircle()
    }
    
    func updateUI(info: SessionInfo) {
        
        if let picture = info.speakers.first?.img.mobile {
        
            speakerImageView.kf.setImage(with: URL(string: picture))
        }

        let language = CurrentLanguage.getLanguage()
        
        switch language {
        
        case Language.chinese.rawValue:
        
            scheduleInfoLabel.text = info.summary
            
            typeLabel.text = info.tags.reduce("", { $0 + $1.name + " "})
            
            topicLabel.text = info.topic
            
            speakerName.text = info.speakers.first?.name
            
            speakerJob.text = "\(info.speakers.first?.jobTitle ?? "")@\(info.speakers.first?.company ?? "")"
        
        case Language.english.rawValue:
        
            scheduleInfoLabel.text = info.summaryEn
            
            typeLabel.text = info.tags.reduce("", { $0 + $1.name + " "})
            
            topicLabel.text = info.topicEn
            
            speakerName.text = info.speakers.first?.name
            
            speakerJob.text = "\(info.speakers.first?.jobTitleEn ?? "")@\(info.speakers.first?.companyEn ?? "")"
        
        default:
        
            break
        }
    }
}
