//
//  BannerCollectionViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/1.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var bannerData = [Carousel.Payload]()
    
    @IBOutlet weak var bannerImageCollectionView: UICollectionView! {
        didSet {
            bannerImageCollectionView.isPagingEnabled = true
        }
    }
    
    func getBannerData() {
        if let url = URL(string: "https://dev.mopcon.org/2018/api/carousel") {
            CarouselAPI.getAPI(url: url) { (bannerData, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                if let data = bannerData {
                    self.bannerData = data
                    print("Banner 數量：\(self.bannerData.count)")
                    DispatchQueue.main.async {
                        self.bannerImageCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.bannerImageCell, for: indexPath) as! BannerImageCell
        if let url = URL(string: bannerData[indexPath.item].banner) {
            cell.updateUI(url: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: bannerData[indexPath.row].link) {
            UIApplication.shared.open(url, options: [:])
        }
    }
   
}

extension BannerCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

