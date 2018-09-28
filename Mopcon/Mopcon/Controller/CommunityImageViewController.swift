//
//  CommunityImageViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol CollectionViewItemDidSelected {
    func collectionViewItemDidSelected(index:IndexPath, community:Community.Payload)
    func stopSpinner()
}

class CommunityImageViewController: UIViewController {
    
    var communitys = [Community.Payload]()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var delegate: CollectionViewItemDidSelected?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        getCommunity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCommunity() {
        
        CommunityAPI.getAPI(url: MopconAPI.shared.community) { (payload, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                self.delegate?.stopSpinner()
                return
            }
            
            if let payload = payload {
                self.communitys = payload
                DispatchQueue.main.async {
                    self.imageCollectionView.reloadData()
                    self.delegate?.stopSpinner()
                }
            }
        }
    }
    
}

extension CommunityImageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communitys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let communityImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell, for: indexPath) as! CommunityImageCollectionViewCell
        communityImageCell.updateUI(community: communitys[indexPath.row])
        return communityImageCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewItemDidSelected(index: indexPath, community: communitys[indexPath.row])
    }
    
}

extension CommunityImageViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, self.view.frame.width * (16/375), self.view.frame.height * (16/667), self.view.frame.width * (16/375))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.height * (16/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.height * (8/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 164/375, height: self.view.frame.width * 164/375)
    }
}
