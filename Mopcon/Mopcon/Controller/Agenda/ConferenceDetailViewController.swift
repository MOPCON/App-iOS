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
    
    @IBOutlet weak var communityPartner: UILabel!
    
    
    @IBOutlet weak var scheduleInfoLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sponsorTitleLabel: UILabel!
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var tags: [Tag] = [] {
        
        didSet {
        
            tagView.reloadData()
        }
    }
    
    var room: Room?
    
    var categoryStartIndex: Int = 0
    
    @IBOutlet weak var tagView: MPTagView! {
        
        didSet {
        
            tagView.dataSource = self
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
            
            
            sponsorImageView.kf.setImage(with: URL(string: sponsor.logo))
            
        } else {
            
            sponsorImageView.isHidden = true
            
            sponsorTitleLabel.isHidden = true
            
        }
        
        imageStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

        for speaker in room.speakers {
            
            let speakerAvatarView = SpeakerAvatarView()
            
            speakerAvatarView.loadImage(speaker.img.mobile)
            
            imageStackView.addArrangedSubview(speakerAvatarView)
          
//            speakerAvatarView.widthAnchor.constraint(
//                equalTo: view.widthAnchor,
//                multiplier: 100/375
//            ).isActive = true
            
            //////////////////////////////////////////////////

            let coverImageView = UIImageView()

            speakerAvatarView.addSubview(coverImageView)
            let coverImage = UIImage.asset(.coverImage)

            coverImageView.image = coverImage

            coverImageView.translatesAutoresizingMaskIntoConstraints = false
            coverImageView.contentMode = .scaleAspectFill

            speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: speakerAvatarView, attribute: .width, multiplier: 1, constant: 0))

            speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: speakerAvatarView, attribute: .height, multiplier: 1, constant: 0))

            speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .top, relatedBy: .equal, toItem: speakerAvatarView, attribute: .top, multiplier: 1, constant: 0))

            speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .left, relatedBy: .equal, toItem: speakerAvatarView, attribute: .left, multiplier: 1, constant: 0))
        }
        
        if !room.communityPartner.isEmpty {
        
            communityPartner.text! += "#合作社群－\(room.communityPartner)"
        }
       
        
        generateTags(room: room)
        
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
    
    func generateTags(room: Room) {
        
        tags = []
        
        if room.isKeynote {
            
            tags.append(TagFactory.keynoteTag())
        }
        
        if room.isOnline {
            
            tags.append(TagFactory.onlineTag())
        }
        
        if !room.recordable {
            
            tags.append(TagFactory.unrecordableTag())
        }
        
        if room.sponsorId != 0 {
            
            tags.append(TagFactory.partnerTag())
        }
        
        categoryStartIndex = tags.count - 1
        
        for category in room.tags {
            
            tags.append(category)
        }

    }
}

extension ConferenceDetailViewController: MPTagViewDataSource {
    
    func numberOfTags(_ tagView: MPTagView) -> Int {
        
        return tags.count
    }
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String {
        
        return tags[index].name
    }
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor? {
        
        return UIColor(hex: tags[index].color.mobile)
    }
    
    func viewType(_ tagView: MPTagView, index: Int) -> TagViewType {
        
        return (index > categoryStartIndex) ? .solid : .hollow
    }
}
