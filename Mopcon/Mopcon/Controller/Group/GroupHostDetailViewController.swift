//
//  ComminityDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum HostType {
    
    case community(String)
    
    case participant(Int)
    
    case normal
}

class GroupHostDetailViewController: MPBaseViewController {
    
    var hostType: HostType = .normal {
        
        didSet {
        
            switch hostType {
                
            case .community(let id):
                
                fetchOrganizer(id: id)
                
            case .participant(let id):
            
                fetchParticipant(id: id)
                
            case .normal: emptyView.isHidden = false
            }
        }
    }
    
    var fb: String?
    
    var twitter: String?
    
    var website: String?
    
    var event: String?
    
    @IBOutlet weak var communityDetailImageView: UIImageView!
    
    @IBOutlet weak var communityNameLabel: UILabel!
    
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var socialMediaStackView: UIStackView!
    
    @IBOutlet weak var emptyView: UIView!
    
    let scrollView = UIScrollView()
    
    //MARK: - Action
    @objc func openFB(_ sender: UIButton) {
        
        openURL(fb)
    }
    
    @objc func openTwitter(_ sender: UIButton) {
        
        openURL(twitter)
    }
    
    @objc func openWebsite(_ sender: UIButton) {
        openURL(website)
    }
    
    @IBAction func openEvent(_ sender: UIButton) {
        
        guard let event = event,
              event != ""
        else {
            
            return openURL(fb)
        }
        
        openURL(event)
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        moreBtn.layer.cornerRadius = 6
        
        moreBtn.layer.borderColor = UIColor.secondThemeColor?.cgColor
        
        moreBtn.layer.backgroundColor = UIColor.mainThemeColor?.cgColor
        
        moreBtn.setTitleColor(UIColor.secondThemeColor, for: .normal)
        
        moreBtn.layer.borderWidth = 1.0
        
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        communityDetailImageView.makeCircle()
    }
    
    //MARK: Layout
    func setupLayout() {
        
        emptyView.backgroundColor = UIColor.dark
        
        emptyView.isHidden = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(scrollView, belowSubview: emptyView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor )
        ])
        
        communityDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(communityDescriptionLabel)
        
        NSLayoutConstraint.activate([
            communityDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            communityDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            communityDescriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 214),
            communityDescriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -244),
            communityDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0, constant: -40)
        ])
        
        socialMediaStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(socialMediaStackView)
    
        NSLayoutConstraint.activate([
            socialMediaStackView.centerXAnchor.constraint(equalTo: communityDescriptionLabel.centerXAnchor),
            socialMediaStackView.bottomAnchor.constraint(equalTo: communityDescriptionLabel.topAnchor, constant: -16)
        ])
        
        moreBtn.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(moreBtn)
        
        NSLayoutConstraint.activate([
            moreBtn.centerXAnchor.constraint(equalTo: communityDescriptionLabel.centerXAnchor),
            moreBtn.topAnchor.constraint(equalTo: communityDescriptionLabel.bottomAnchor, constant: 76),
            moreBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 172/375),
            moreBtn.heightAnchor.constraint(equalTo: moreBtn.widthAnchor, multiplier: 52/172)
        ])
        
        communityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(communityNameLabel)
        
        NSLayoutConstraint.activate([
            communityNameLabel.centerXAnchor.constraint(equalTo: communityDescriptionLabel.centerXAnchor),
            communityNameLabel.bottomAnchor.constraint(equalTo: socialMediaStackView.topAnchor, constant: -16)
        ])
        
        communityDetailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(communityDetailImageView)
        
        NSLayoutConstraint.activate([
            communityDetailImageView.centerXAnchor.constraint(equalTo: communityDescriptionLabel.centerXAnchor),
            communityDetailImageView.heightAnchor.constraint(equalToConstant: 80),
            communityDetailImageView.widthAnchor.constraint(equalTo: communityDetailImageView.heightAnchor),
            communityDetailImageView.bottomAnchor.constraint(equalTo: communityNameLabel.topAnchor, constant: -26)
        ])
    }
    
    private func setupStackView() {
        
        if fb != "" {
            
            let button = ButtonFactor.facebookButton()
         
            socialMediaStackView.addArrangedSubview(button)
            
            button.addTarget(self, action: #selector(openFB(_:)), for: .touchUpInside)
        }
        
        if twitter != "" {
            
            let button = ButtonFactor.twitterButton()
         
            socialMediaStackView.addArrangedSubview(button)
            
            button.addTarget(self, action: #selector(openTwitter(_:)), for: .touchUpInside)
        }
        
        if website != "" {

            let button = ButtonFactor.webSiteButton()
         
            socialMediaStackView.addArrangedSubview(button)
            
            button.addTarget(self, action: #selector(openWebsite(_:)), for: .touchUpInside)
        }
    }
    
    func updateUI(image: String, name: String, introduction: String) {

        emptyView.isHidden = true
        
        communityDetailImageView.loadImage(image)
        
        communityNameLabel.text = name
        
        communityDescriptionLabel.text = introduction
    }
    
    //MARK: - API
    
    func fetchOrganizer(id: String) {
        
        GroupProvider.fetchOrganizer(
            id: id,
            completion: { [weak self] result in
            
                switch result{
                    
                case .success(let organizer):
                    
                    self?.updateUI(image: organizer.photo, name: organizer.name, introduction: organizer.introduction)
                    
                    self?.fb = organizer.facebook
                    
                    self?.twitter = organizer.twitter

                    self?.website = organizer.event
                    
                    self?.event = organizer.event
                    
                    self?.setupStackView()
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
    }
    
    func fetchParticipant(id: Int) {
        
        GroupProvider.fetchParticipant(
            id: id,
            completion: { [weak self] result in
            
                switch result{
                    
                case .success(let participanter):
                    
                    self?.updateUI(
                        image: participanter.photo.mobile,
                        name: participanter.name,
                        introduction: participanter.introduction
                    )
                    
                    self?.fb = participanter.facebook
                    
                    self?.twitter = participanter.twitter
                    
                    self?.website = participanter.event
                    
                    self?.event = participanter.event
                    
                    self?.setupStackView()
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
    }
}
