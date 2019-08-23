//
//  VolunteerViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class VolunteerViewController: GroupBaseViewController {
    
    var volunteers = [Volunteer.Payload]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getData()
    }
    
    func getData() {
        
        VolunteerAPI.getAPI(url: MopconAPI.shared.volunteer) { [weak self] (volunteers, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let volunteers = volunteers {
                
                self?.volunteers = volunteers
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIDManager.performCommunityDetail,
           let destinationVC = segue.destination as? VolunteerDetailViewController {
            
            destinationVC.loadViewIfNeeded()
            
            destinationVC.volunteer = sender as? Volunteer.Payload
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return volunteers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let communityImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell,
            for: indexPath
        ) as! CommunityImageCollectionViewCell
        
        communityImageCell.updateUI(image: volunteers[indexPath.row].image(), title: volunteers[indexPath.row].groupname)
        
        return communityImageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueIDManager.performCommunityDetail, sender: volunteers[indexPath.row])
    }
    
}
