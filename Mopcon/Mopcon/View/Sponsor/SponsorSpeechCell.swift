//
//  SponsorSpeechCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/26.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class SponsorSpeechCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var sponsorSpeaker: [SponsorSpeaker] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: SessionCollectionViewCell.identifier, bundle: nil)
        
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: SessionCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
    }
}

extension SponsorSpeechCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sponsorSpeaker.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SessionCollectionViewCell.identifier, for: indexPath)
        
        guard let sessionCell = cell as? SessionCollectionViewCell else { return cell }
        
        sessionCell.updateUI(sponsorSpeaker[indexPath.row])
        
        return sessionCell
    }
}

extension SponsorSpeechCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: collectionView.frame.width - 40,
            height: collectionView.frame.height
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
}
