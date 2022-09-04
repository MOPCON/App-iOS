//
//  SpeakerDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/3.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakerDetailViewController: MPBaseViewController {
    
    @IBOutlet weak var speakerView: SpeakerView!
    
    @IBOutlet weak var speakerDetailView: SpeakerDetailView!
    
    @IBOutlet weak var talkInfoView: SpeakerTalkInfoView! {
        
        didSet {
        
            talkInfoView.delegate = self
            
            talkInfoView.tagView.dataSource = self
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var scheduleTopicLabelHeighConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tagViewHeightConstraint: NSLayoutConstraint!
    
    let spinner = LoadingTool.setActivityindicator()
    
    var speaker: Speaker?

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let speaker = speaker {
            
            updateUI(speaker: speaker)
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        scrollView.addSubview(speakerView)
        
        speakerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(speakerDetailView)
        
        speakerDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(talkInfoView)
        
        talkInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            speakerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            speakerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            speakerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            speakerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            speakerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            speakerDetailView.topAnchor.constraint(equalTo: speakerView.bottomAnchor),
            speakerDetailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            speakerDetailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            talkInfoView.topAnchor.constraint(equalTo: speakerDetailView.bottomAnchor),
            talkInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            talkInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            talkInfoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    //MARK: Layout out
    
    private func addStarCircleView() {
        let coverImageView = UIImageView()

        self.speakerView.speakerAvatarView.addSubview(coverImageView)
        
        let coverImage = UIImage.asset(.coverImage)

        coverImageView.image = coverImage

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        coverImageView.contentMode = .scaleAspectFill

        self.speakerView.speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: self.speakerView.speakerAvatarView, attribute: .width, multiplier: 1, constant: 0))

        self.speakerView.speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: self.speakerView.speakerAvatarView, attribute: .height, multiplier: 1, constant: 0))

        self.speakerView.speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .top, relatedBy: .equal, toItem: self.speakerView.speakerAvatarView, attribute: .top, multiplier: 1, constant: 0))

        self.speakerView.speakerAvatarView.addConstraint(NSLayoutConstraint.init(item: coverImageView, attribute: .left, relatedBy: .equal, toItem: self.speakerView.speakerAvatarView, attribute: .left, multiplier: 1, constant: 0))
    }
    
    
    func updateUI(speaker: Speaker) {
        
        self.speaker = speaker
        
        let imgUrl = MPConstant.baseURL + "/" + speaker.img.mobile
        
        speakerView.updateUI(
            image:imgUrl,
            name: speaker.name,
            job: speaker.jobTitle + "@" + speaker.company
        )

        speakerDetailView.updateUI(info: speaker.bio)

        let start = DateFormatter.string(for: speaker.startedAt, formatter: "MM/dd HH:mm") ?? ""
        
        let end = DateFormatter.string(for: speaker.endedAt, formatter: "HH:mm") ?? ""
        

        talkInfoView.updateUI(
            topic: speaker.topic,
            speakerName: (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? speaker.name : speaker.nameEn,
            time: start + " - " + end,
            position: speaker.room + " " + speaker.floor,
            isCollected: FavoriteManager.shared.fetchSessionIds().contains(speaker.sessionID)
        )
        
        talkInfoView.tagView.reloadData()
        
        talkInfoView.scheduleTopicLabel.sizeToFit()
        
        self.scheduleTopicLabelHeighConstraint.constant = max(talkInfoView.scheduleTopicLabel.frame.size.height,self.scheduleTopicLabelHeighConstraint.constant)
        
        /** 取得正確的 CollectionView Flowlayout Contentsize*/
        talkInfoView.tagView.colletionView.collectionViewLayout.invalidateLayout()
        talkInfoView.tagView.colletionView.collectionViewLayout.prepare();
        talkInfoView.tagView.colletionView.layoutIfNeeded()
        
        self.tagViewHeightConstraint.constant = talkInfoView.tagView.colletionView.collectionViewLayout.collectionViewContentSize.height + 5
        
        setupButton(speaker: speaker)
        addStarCircleView()
    }
    
    func setupButton(speaker: Speaker) {
        
        if speaker.linkFb != "" {
            
            let button = ButtonFactor.facebookButton()
            
            button.addTarget(self, action: #selector(openFacebook(_:)), for: .touchUpInside)
            
            buttonStackView.addArrangedSubview(button)
        }
        
        if speaker.linkGithub != "" {
            
            let button = ButtonFactor.githubButton()
            
            button.addTarget(self, action: #selector(openGitHub(_:)), for: .touchUpInside)
            
            buttonStackView.addArrangedSubview(button)
        }
        
        if speaker.linkTwitter != "" {
            
            let button = ButtonFactor.twitterButton()
            
            button.addTarget(self, action: #selector(openTwitter(_:)), for: .touchUpInside)
            
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    @objc func openFacebook(_ sender: UIButton) {
        openURL(speaker?.linkFb)
    }

    @objc func openGitHub(_ sender: UIButton) {
        openURL(speaker?.linkGithub)
    }
    
    @objc func openTwitter(_ sender: UIButton) {
        openURL(speaker?.linkTwitter)
    }
}

extension SpeakerDetailViewController: SpeakerTalkInfoViewDelegate {
    
    func didTouchCollectedButton(_ infoView: SpeakerTalkInfoView) {
        
        guard let speaker = speaker else { return }
        
        if infoView.likedButton.isSelected {
            
            spinner.startAnimating()
            
            SessionProvider.fetchSession(id: speaker.sessionID, completion: { [weak self] result in
                
                self?.throwToMainThreadAsync {
                    
                    switch result {
                        
                    case .success(let room):
                        
                        FavoriteManager.shared.addSession(room: room)
                        
                    case .failure(let error):
                        
                        print(error)
                    }
                    
                    self?.spinner.stopAnimating()
                }
            })
            
        } else {
            
            FavoriteManager.shared.removeSession(id: speaker.sessionID)
        }
    }
    
    func didTouchTalkInfoView() {
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
            
            guard let sessionID = speaker?.sessionID else {
                
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
            
            guard let sessionID = speaker?.sessionID else {
                
                return
            }
            
            detailVC.conferenceType = .session(sessionID)
            
            show(detailVC, sender: nil)
        }
    }
}

extension SpeakerDetailViewController: MPTagViewDataSource {
    
    func numberOfTags(_ tagView: MPTagView) -> Int {
        
        return speaker?.tags.count ?? 0
    }
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String {
        
        return speaker?.tags[index].name ?? ""
    }
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor? {
        
        return UIColor(hex: speaker?.tags[index].color.mobile ?? "")
    }
}
