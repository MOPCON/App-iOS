//
//  VolunteerViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class VolunteerViewController: GroupBaseViewController {
    
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
        
        if segue.identifier == SegueIDManager.performCommunityDetail,
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
            image: image(name: volunteer.name),
            title: volunteer.name
        )
        
        return communityImageCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        performSegue(
            withIdentifier: SegueIDManager.performCommunityDetail,
            sender: volunteers[indexPath.row].id
        )
    }
    
    func image(name: String) -> UIImage? {
        
        switch name {
            
        case "議程委員會": return UIImage.asset(.committee_team)
            
        case "行政組": return UIImage.asset(.administrative_team)
            
        case "議程組": return UIImage.asset(.agenda_team)
            
        case "財務組": return UIImage.asset(.finance_team)
            
        case "贊助組": return UIImage.asset(.sponsor_team)
            
        case "公關組": return UIImage.asset(.public_team)
            
        case "資訊組": return UIImage.asset(.into_team)
            
        case "美術組": return UIImage.asset(.art_team)
            
        case "紀錄組": return UIImage.asset(.record_team)
            
        case "錄影組": return UIImage.asset(.video_team)
            
        case "場務組": return UIImage.asset(.place_team)
            
        case "攝影組": return UIImage.asset(.record_team)
            
        default: return nil
            
        }
    }
}
