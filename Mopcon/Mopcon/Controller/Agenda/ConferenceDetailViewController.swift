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
    
    @IBOutlet weak var scheduleInfoHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addToMyScheduleButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sponsorTitleLabel: UILabel!
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var separatorLineView: UIImageView!
    
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
    
    @IBOutlet weak var tagViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
        
        imageStackView.spacing = 90
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        sponsorImageView.makeCircle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        for view in imageStackView.arrangedSubviews
        {
            print(view.frame)
        }
    
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
                    
                    self?.addToMyScheduleButtonItem.tintColor = UIColor.pink
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    // MARK: - Layout View
    func updateUI(room: Room) {
        
        self.locationLabel.text = room.room + ", " + room.floor
        
        let start = DateFormatter.string(for: room.startedAt, formatter: "HH:mm") ?? ""
        let end = DateFormatter.string(for: room.endedAt, formatter: "HH:mm") ?? ""
        
        
        self.timeLabel.text = start + "-" + end
        
        //////////////////////////////////////////////////

        if let sponsor = room.sponsorInfo {
        
            sponsorImageView.isHidden = false
            
            sponsorTitleLabel.isHidden = false
            
            sponsorImageView.kf.setImage(with: URL(string: sponsor.logo))
            
            separatorLineView.isHidden = false
        } else {
            
            sponsorImageView.isHidden = true
            
            sponsorTitleLabel.isHidden = true
            
            separatorLineView.isHidden = true
        }
        
        imageStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

        
        for speaker in room.speakers{
     
            let speakerAvatarView = SpeakerAvatarView()
            
            speakerAvatarView.loadImage(speaker.img.mobile)
            
            imageStackView.addArrangedSubview(speakerAvatarView)
          
//            speakerAvatarView.widthAnchor.constraint(
//                equalTo: view.widthAnchor,
//                multiplier: 100/375
//            ).isActive = true
            
            //////////////////////////////////////////////////

            if(room.speakers.count>1)
            {
                continue;
            }
            
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
        
        
        /**
         計算高度  layoutConstraint Label FontSize = 13
         */
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        
        var totalString = String()
        for tag in tags {
            totalString.append(tag.name)
        }
        
        label.numberOfLines = 0
        label.text = totalString
        let constraintRect = label.sizeThatFits(CGSize(width: self.view.bounds.size.width - 40 - CGFloat(16 * room.tags.count) - CGFloat(10 * room.tags.count), height: CGFloat.greatestFiniteMagnitude))
      
        let boundingBox = totalString.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], context: nil)
        
        self.tagViewHeightConstraint.constant += (ceil(boundingBox.size.height / 20) * (20 + 13) - 20)
        
        
        
        //////////////////////////////////////////////////

        
        
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
