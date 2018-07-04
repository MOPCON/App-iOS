//
//  CommunityImageViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol CollectionViewItemDidSelected {
    func collectionViewItemDidSelected(index:IndexPath, imageName:String)
}

class CommunityImageViewController: UIViewController {
    
    
    let fakeImageArray = ["bitmap","lion","rabbit","greenCircle","yellowHouse","grayStrange","pulse","pulse","company","summit","nbc","companyName"]
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var delegate: CollectionViewItemDidSelected?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CommunityImageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fakeImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let communityImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.communityImageCell, for: indexPath) as! CommunityImageCollectionViewCell
        communityImageCell.updateUI(imageName: fakeImageArray[indexPath.item])
        return communityImageCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewItemDidSelected(index: indexPath, imageName: fakeImageArray[indexPath.item])
    }
    
}

extension CommunityImageViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, self.view.frame.width * (16/375), self.view.frame.height * (16/667), self.view.frame.width * (16/375))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.height * (16/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.height * (16/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 164/375, height: self.view.frame.width * 164/375)
    }
}
