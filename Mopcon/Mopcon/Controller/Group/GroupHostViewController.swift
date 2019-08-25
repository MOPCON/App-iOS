//
//  CommunityImageViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol CollectionViewItemDidSelected: AnyObject {
    
    func stopSpinner()
}

class GroupHostViewController: GroupBaseViewController {
    
    var group: Group?
    
    weak var delegate: CollectionViewItemDidSelected?

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
        
        if segue.identifier == SegueIDManager.performCommunityDetail{
            
            guard
                let groupHostDetailVC = segue.destination as? GroupHostDetailViewController,
                let id = sender as? String
            else { return }
            
            groupHostDetailVC.communityID = id
        }
    }
    
    func fetchGroup() {
        
        GroupProvider.fetchCommunity(completion: { [weak self] result in
            
            switch result {
                
            case .success(let group):
                
                self?.group = group
                
                self?.collectionView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    //MARK: - UICollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        guard let group = group else { return 0 }
        
        return section == 0 ? group.communitys.count : group.participants.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let communityImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell,
            for: indexPath
        ) as! CommunityImageCollectionViewCell
        
        if indexPath.section == 0 {
        
            guard let community = group?.communitys[indexPath.row] else { return communityImageCell }
            
            communityImageCell.updateUI(image: community.photo, title: community.name)
            
        } else {
            
            guard let participant = group?.participants[indexPath.row] else { return communityImageCell }
            
            communityImageCell.updateUI(image: participant.photo, title: participant.name)
        }
        
        
        return communityImageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 40)
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
        
        communityHeader.headerLabel.text = indexPath.section == 0 ? "主辦社群" : "參與社群"
        
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        guard let community = group?.communitys[indexPath.row] else { return }
        
        performSegue(
            withIdentifier: SegueIDManager.performCommunityDetail,
            sender: community.id
        )
    }
    
}

class CommunityCollectionViewHeaderView: UICollectionReusableView {
    
    let headerLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        headerLabel.textColor = UIColor(hex: "#878787")
        
        headerLabel.font = UIFont.systemFont(ofSize: 14)
    }
}
