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
    
    var communitys = [Community.Payload]()
    
    weak var delegate: CollectionViewItemDidSelected?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCommunity()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIDManager.performCommunityDetail{
            
            guard
                let groupHostDetailVC = segue.destination as? GroupHostDetailViewController,
                let community = sender as? Community.Payload
            else { return }
            
            groupHostDetailVC.community = community
        }
    }
    
    func getCommunity() {
        
        CommunityAPI.getAPI(url: MopconAPI.shared.community) { [weak self] (payload, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                self?.delegate?.stopSpinner()
                return
            }
            
            if let payload = payload {
                self?.communitys = payload
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.delegate?.stopSpinner()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communitys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let communityImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell, for: indexPath) as! CommunityImageCollectionViewCell
        communityImageCell.updateUI(image: communitys[indexPath.row].logo, title: communitys[indexPath.row].title)
        return communityImageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueIDManager.performCommunityDetail, sender: communitys[indexPath.row])
    }
}
