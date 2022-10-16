//
//  CommunityImageViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol GroupHostViewControllerDelegate: AnyObject {
    
    func stopSpinner()
}

class GroupHostViewController: GroupBaseViewController {
    
    struct Segue {
        
        static let detail = "SegueGroupDetail"
    }
    
    var group: Group?
    
    weak var delegate: GroupHostViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGroup()
        
        collectionView.register(
            CommunityCollectionViewHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CommunityCollectionViewHeaderView.identifier
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.detail {
            
            guard let groupHostDetailVC = segue.destination as? GroupHostDetailViewController,
                  let hostType = sender as? HostType
            else {
                
                return
            }
            
            groupHostDetailVC.hostType = hostType
        }
    }
    
    func fetchGroup() {
        
        GroupProvider.fetchCommunity(completion: { [weak self] result in
            
            switch result {
                
            case .success(let group):
                
                self?.group = group
                
                self?.delegate?.stopSpinner()
                
                self?.collectionView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    //MARK: - UICollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        var count = 0
        
        guard let group = group else {
            return count
        }
        
        let communitysCount = (group.communitys.count>0) ? 1 : 0
        
        let participantsCount = (group.participants.count>0) ? 1 : 0
        
        count = communitysCount + participantsCount
        return count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        guard let group = group else { return 0 }
        
        if(self.numberOfSections(in: collectionView)>=2)
        {
            if(section==0)
            {
                return group.communitys.count
            }
            else
            {
                return group.participants.count
            }
        }
        else
        {
            return group.participants.count
        }
        
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let communityImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell,
            for: indexPath
        ) as! CommunityImageCollectionViewCell
                   
        if(self.numberOfSections(in: collectionView) >= 2)
        {
            if(indexPath.section == 0)
            {
                guard let community = group?.communitys[indexPath.row] else { return communityImageCell }
                
                communityImageCell.updateUI(image: community.photo, title: community.name)
                
            }
            else
            {
                guard let participant = group?.participants[indexPath.row] else { return communityImageCell }
                
                communityImageCell.updateUI(image: participant.photo.mobile, title: participant.name)
                
            }
        }
        else
        {
            guard let participant = group?.participants[indexPath.row] else { return communityImageCell }
            
            communityImageCell.updateUI(image: participant.photo.mobile, title: participant.name)
            
        }
        
        return communityImageCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(
            width: self.view.frame.width * (164 / 375),
            height: 100
        )
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 24, left: self.view.frame.height * (16 / 667), bottom: self.view.frame.height * (16 / 667), right: self.view.frame.width * (16 / 375))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CommunityCollectionViewHeaderView.identifier,
            for: indexPath
        )
        
        guard let communityHeader = header as? CommunityCollectionViewHeaderView else {
            
            return header
        }
        
        if(self.numberOfSections(in: collectionView) >= 2)
        {
            if(indexPath.section == 0)
            {
                communityHeader.updateUI(title: "主辦社群")
                
            }
            else
            {
                communityHeader.updateUI(title: "參與社群")
                
            }
        }
        else
        {
            communityHeader.updateUI(title: "參與社群")
        }

        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        guard let participant = group?.participants[indexPath.row] else { return }
        
        performSegue(withIdentifier: Segue.detail, sender: HostType.participant(participant.id))
    }
    
}

class CommunityCollectionViewHeaderView: UICollectionReusableView {

    let iconImageView = UIImageView()
    
    let seperatorView = UIImageView()
    
    let headerLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        prepareImg()
        
        setupLayout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareImg()

        setupLayout()
    }

    private func updateIcon()
    {
        if(headerLabel.text=="參與社群")
        {
            self.iconImageView.image =  UIImage.asset(.participant)
        }
        else
        {
            self.iconImageView.image =  UIImage.asset(.communlity)
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Private method

    private func prepareImg(){
        self.seperatorView.image = UIImage.asset(.vector)
    }
    
    private func setupLayout() {
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconImageView)
        addSubview(headerLabel)
        addSubview(seperatorView)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            headerLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            seperatorView.heightAnchor.constraint(equalToConstant: 10),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        headerLabel.textColor = UIColor.pink

        headerLabel.font = UIFont.systemFont(ofSize: 16)
        
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Instance method
    
    func updateUI(title:String)
    {
        self.headerLabel.text = title
        
        self.updateIcon()
    }
}
