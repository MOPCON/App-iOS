//
//  CommunityImageViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol CollectionViewItemDidSelected: AnyObject {
    
    func collectionViewItemDidSelected(index:IndexPath, community:Community.Payload)
    
    func stopSpinner()
}

class CommunityImageViewController: UIViewController {
    
    var communitys = [Community.Payload]()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    let joinVolunteerView = JoinVolunteerView()
    
    private let joinViewHeight: CGFloat = 537.0
    
    weak var delegate: CollectionViewItemDidSelected?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        
        imageCollectionView.dataSource = self
        
        getCommunity()
        
        imageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: joinViewHeight, right: 0)
        
        joinVolunteerView.frame = CGRect(
            origin: CGPoint(x: 0, y: imageCollectionView.contentSize.height),
            size: CGSize(width: imageCollectionView.frame.width, height: joinViewHeight)
        )
        
        imageCollectionView.addSubview(joinVolunteerView)
        
        joinVolunteerView.isHidden = true
        
        joinVolunteerView.delegate = self
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
                    self?.imageCollectionView.reloadData()
                    self?.delegate?.stopSpinner()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row > communitys.count - 2 {
            
            joinVolunteerView.frame.origin = CGPoint(x: 0, y: collectionView.contentSize.height)
            
            joinVolunteerView.isHidden = false
        }
    }
}

extension CommunityImageViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: self.view.frame.width * (16/375), bottom: self.view.frame.height * (16/667), right: self.view.frame.width * (16/375))
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

extension CommunityImageViewController: JoinVolunteerViewDelegate {
    
    func didTouchFacebookButton(_ volunteerView: JoinVolunteerView) {
        
        //TODO
        
        //Open Facebook link
        
        print("---------")
        print("didTouchFacebookButton in CommunityImageViewController")
    }
}
