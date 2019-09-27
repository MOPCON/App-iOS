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
    
    case participant(String)
    
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
    
    var url: String?
    
    @IBOutlet weak var communityDetailImageView: UIImageView!
    
    @IBOutlet weak var communityNameLabel: UILabel!
    
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var socialMediaStackView: UIStackView!
    
    @IBOutlet weak var emptyView: UIView!
    
    let scrollView = UIScrollView()
    
    @IBAction func connectToFacebook(_ sender: UIButton) {
        
        if let urlString = url,
           let url = URL(string: urlString) {
        
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        facebookButton.layer.cornerRadius = 15
        
        facebookButton.layer.borderColor = UIColor.azure?.cgColor
        
        facebookButton.layer.borderWidth = 1.0
        
        setupLayout()
    }
    
    func setupLayout() {
        
        emptyView.backgroundColor = UIColor.dark
        
        emptyView.isHidden = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(scrollView, belowSubview: emptyView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
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
        
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(facebookButton)
        
        NSLayoutConstraint.activate([
            facebookButton.centerXAnchor.constraint(equalTo: communityDescriptionLabel.centerXAnchor),
            facebookButton.topAnchor.constraint(equalTo: communityDescriptionLabel.bottomAnchor, constant: 76),
            facebookButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 172/375),
            facebookButton.heightAnchor.constraint(equalTo: facebookButton.widthAnchor, multiplier: 52/172)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        communityDetailImageView.makeCircle()
    }
    
    func fetchOrganizer(id: String) {
        
        GroupProvider.fetchOrganizer(
            id: id,
            completion: { [weak self] result in
            
                switch result{
                    
                case .success(let organizer):
                    
                    self?.updateUI(image: organizer.photo, name: organizer.name, introduction: organizer.introduction)
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
    }
    
    func fetchParticipant(id: String) {
        
        GroupProvider.fetchParticipant(
            id: id,
            completion: { [weak self] result in
            
                switch result{
                    
                case .success(let participanter):
                    
                    self?.updateUI(
                        image: participanter.photo,
                        name: participanter.name,
                        introduction: participanter.introduction
                    )
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
    }
    
    func updateUI(image: String, name: String, introduction: String) {

        emptyView.isHidden = true
        
        communityDetailImageView.loadImage(image)
        
        communityNameLabel.text = name
        
        communityDescriptionLabel.text = introduction
    }
}
