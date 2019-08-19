//
//  GroupBaseViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/8.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class GroupBaseViewController: MPBaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, JoinVolunteerViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            collectionView.delegate = self
            
            collectionView.dataSource = self
        }
    }
    
    let joinVolunteerView = JoinVolunteerView()
    
    private let joinViewHeight: CGFloat = 537.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: joinViewHeight, right: 0)
        
        joinVolunteerView.frame = CGRect(
            origin: CGPoint(x: 0, y: collectionView.contentSize.height),
            size: CGSize(width: collectionView.frame.width, height: joinViewHeight)
        )
        
        collectionView.addSubview(joinVolunteerView)
        
        joinVolunteerView.isHidden = true
        
        joinVolunteerView.delegate = self
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
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
    
    //MARK: - UICollectionDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row > collectionView.numberOfItems(inSection: 0) - 2 {
            
            joinVolunteerView.frame.origin = CGPoint(x: 0, y: collectionView.contentSize.height)
            
            joinVolunteerView.isHidden = false
        }
    }
    
    
    //MARK: - JoinVolunteerViewDelegate
    func didTouchFacebookButton(_ volunteerView: JoinVolunteerView) {
        
        //TODO
        
        print("---------")
        print("didTouchFacebookButton in CommunityImageViewController")
    }
    
}
