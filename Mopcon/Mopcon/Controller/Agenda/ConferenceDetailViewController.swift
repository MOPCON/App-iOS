//
//  ConferenceDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum ConferenceType {
    
    case session(Int)
}

class ConferenceDetailViewController: MPBaseViewController {
    
    var conferenceType: ConferenceType? {
        
        didSet {
            
            switch conferenceType {
            
            case .session(let id): fetchSessionInfo(id: id)
                
            default: scrollView.isHidden = true
        
            }
        }
    }
        
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var imageStackView: UIStackView!
    
    @IBOutlet weak var speakerName: UILabel!
    
    @IBOutlet weak var speakerJob: UILabel!
    
    @IBOutlet weak var scheduleInfoLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sponsorTitleLabel: UILabel!
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    @IBOutlet weak var sponsorLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var tags: [Tag] = [] {
        
        didSet {
        
            tagView.reloadData()
        }
    }
    
    var categoryTags: [Tag] = [] {
        
        didSet {
            
            categoryTagView.reloadData()
        }
    }
    
    var room: Room?
    
    @IBOutlet weak var tagView: MPTagView! {
        
        didSet {
        
            tagView.dataSource = self
        }
    }
    
    @IBOutlet weak var categoryTagView: MPTagView! {
        
        didSet {
            
            categoryTagView.dataSource = self
        }
    }
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        sponsorImageView.makeCircle()
    }
    
    @IBAction func didTouchedLikedBtn(_ sender: UIBarButtonItem) {
        
        if sender.image == UIImage.asset(.like) {
            
            switch conferenceType {
                
            case .session(let id): FavoriteManager.shared.removeSession(id: id)
            
            default: break
                
            }
            
            sender.image = UIImage.asset(.dislike)
            
        } else {
            
            switch conferenceType {
                
            case .session(_):
                
                guard let room = room else { return }
                
                FavoriteManager.shared.addSession(room: room)
            
            default: break
                
            }
            
            sender.image = UIImage.asset(.like)
        }
    }
    
    //MARK: - API
    
    private func fetchSessionInfo(id: Int) {
        
        SessionProvider.fetchSession(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let room):
                
                self?.throwToMainThreadAsync {
                    
                    self?.room = room
                    
                    self?.updateUI(room: room)
                    
                    self?.scrollView.isHidden = false
                    
                    if FavoriteManager.shared.fetchSessionIds().contains(id) {
                        
                        self?.addToMyScheduleButtonItem.image = UIImage.asset(.like)
                        
                    } else {
                        
                        self?.addToMyScheduleButtonItem.image = UIImage.asset(.dislike)
                    }
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
        
        imageStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

        for speaker in room.speakers {
            
            let imageView = UIImageView()
            
            imageView.loadImage(speaker.img.mobile)
            
            imageStackView.addArrangedSubview(imageView)
            
            imageView.contentMode = .scaleAspectFit
            
            imageView.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 80/375
            ).isActive = true
        }
        
        generateTags(room: room)
        
        generateCategoryTags(room: room)

        let language = CurrentLanguage.getLanguage()

        switch language {

        case Language.chinese.rawValue:

            scheduleInfoLabel.text = room.summary
            
            topicLabel.text = room.topic

            speakerName.text = room.speakers.map({ $0.name }).joined(separator: " | ")

            let jobs = room.speakers
                .map({ "\($0.jobTitle)@\($0.company)"})
                .joined(separator: " | ")

            speakerJob.text = jobs

        case Language.english.rawValue:

            scheduleInfoLabel.text = room.summaryEn

            topicLabel.text = room.topicEn

            speakerName.text = room.speakers.map({ $0.nameEn }).joined(separator: " | ")

            let jobs = room.speakers
            .map({ "\($0.jobTitleEn)@\($0.companyEn)"})
            .joined(separator: " | ")

            speakerJob.text = jobs

        default:

            break
        }
    }
    
    private func generateTags(room: Room) {
        
        tags = []
        
        if room.isKeynote {
            
            tags.append(TagFactory.keynoteTag())
        }
        
        if !room.recordable {
            
            tags.append(TagFactory.unrecordableTag())
        }
        
        if room.sponsorId != 0 {
            
            tags.append(TagFactory.partnerTag())
        }
        
        tags.append(TagFactory.levelTag(level: room.level))
        
    }
    
    private func generateCategoryTags(room: Room) {
        
        categoryTags = []
        
        for category in room.tags {
            
            categoryTags.append(category)
        }
        
    }
}

extension ConferenceDetailViewController: MPTagViewDataSource {
    
    func numberOfTags(_ tagView: MPTagView) -> Int {
        
        if tagView == self.tagView {
            
            return tags.count
            
        } else {
            
            return categoryTags.count
        }
    }
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String {
        
        if tagView == self.tagView {
            
            return tags[index].name
            
        } else {
            
            return categoryTags[index].name
        }
                
    }
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor? {
        
        return UIColor(hex: tags[index].color.mobile)
    }
    
    func viewType(_ tagView: MPTagView, index: Int) -> TagViewType {
        
        if tagView == self.tagView {
            
            return .hollow
        
        } else {
            
            return .solid
        }
   
    }
}
