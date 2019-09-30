//
//  LobbySessionCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol LobbySessionCellDelegate: AnyObject {
    
    func likeButtonDidTouched(_ cell: LobbySessionCell, id: Int)
}

class LobbySessionCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var rooms: [Room] = []
    
    weak var delegate: LobbySessionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerNib(identifier: SessionCollectionViewCell.identifier)
    }
    
    func updateUI(rooms: [Room]) {
        
        self.rooms = rooms

        collectionView.reloadData()
    }
}

extension LobbySessionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SessionCollectionViewCell.identifier,
            for: indexPath
        )
        
        guard let sessionCell = cell as? SessionCollectionViewCell else { return cell }
        
        sessionCell.updateUI(rooms[indexPath.row])
        
        sessionCell.delegate = self
        
        return cell
    }
}

extension LobbySessionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
    
        return CGSize(
            width: collectionView.frame.width - 40,
            height: collectionView.frame.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 12
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 0
    }
}

extension LobbySessionCell: SessionCollectionViewCellDelegate {
    
    func likeButtonDidTouched(_ cell: SessionCollectionViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        delegate?.likeButtonDidTouched(self, id: rooms[indexPath.row].sessionId)
    }
}
