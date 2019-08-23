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
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return group?.communitys.count ?? 0
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let communityImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell,
            for: indexPath
        ) as! CommunityImageCollectionViewCell
        
        guard let community = group?.communitys[indexPath.row] else { return communityImageCell }
        
        communityImageCell.updateUI(image: community.photo, title: community.name)
        
        return communityImageCell
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
