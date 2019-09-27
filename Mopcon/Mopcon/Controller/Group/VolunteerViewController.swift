//
//  VolunteerViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class VolunteerViewController: GroupBaseViewController {
    
    struct Segue {
        
        static let detail = "SegueDetail"
    }
    
    var volunteers: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchVolunteerList()
    }
    
    func fetchVolunteerList() {
        
        GroupProvider.fetchVolunteerList(completion: { [weak self] result in
            
            switch result{
                
            case .success(let volunteers):
                
                self?.volunteers = volunteers.list
                
                self?.collectionView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.detail,
           let destinationVC = segue.destination as? VolunteerDetailViewController {
            
            destinationVC.volunteerId = sender as? String
        }
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return volunteers.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let communityImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell,
            for: indexPath
        ) as! CommunityImageCollectionViewCell
        
        let volunteer = volunteers[indexPath.row]
        
        communityImageCell.updateUI(
            image: volunteer.photo,
            title: volunteer.name
        )
        
        return communityImageCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        performSegue(
            withIdentifier: Segue.detail,
            sender: volunteers[indexPath.row].id
        )
    }
}
