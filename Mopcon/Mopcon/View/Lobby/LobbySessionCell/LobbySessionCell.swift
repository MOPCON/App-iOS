//
//  LobbySessionCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol LobbySessionCellDelegate: AnyObject {
    
    func likeButtonDidTouched(_ cell: LobbySessionCell, id: Int, isLiked: Bool)
    
    func moreButtonDidTouched(_ cell: LobbySessionCell)
    
    func didSelectedSession(_ cell: LobbySessionCell, sessionId: Int)
}

enum ViewState<T> {
    
    case normal(T)
    
    case empty
}

class LobbySessionCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyView: UIView! {
        
        didSet {
        
            emptyView.layer.cornerRadius = 6
            
            emptyView.layer.borderColor = UIColor.secondThemeColor?.cgColor
            
            emptyView.layer.borderWidth = 1.0
            
            emptyView.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var moreBtn: UIButton! {
        
        didSet {
        
            moreBtn.layer.cornerRadius = 10
            moreBtn.tintColor = UIColor.pink
        }
    }
    
    var state: ViewState<[Room]> = .empty {
        
        didSet {
            
            switch state {
                
            case .normal(_):
                
                collectionView.isHidden = false
                
                emptyView.isHidden = true
                
                collectionView.reloadData()
                
            case .empty:
            
                collectionView.isHidden = true
            
                emptyView.isHidden = false
            }
        }
    }
    
    var rooms: [Room] {

        switch state {
            
        case .normal(let rooms): return rooms
            
        case .empty: return []
        
        }
    }
    
    weak var delegate: LobbySessionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerNib(identifier: SessionCollectionViewCell.identifier)
    }
    
    func updateUI(rooms: [Room]) {
        
        guard rooms.count > 0 else {
            
            state = .empty
            
            return
        }
        
        state = .normal(rooms)
    }
    
    @IBAction func didTouchMoreBtn(_ sender: UIButton) {
        
        delegate?.moreButtonDidTouched(self)
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

extension LobbySessionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectedSession(self, sessionId: rooms[indexPath.row].sessionId)
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
    
    func likeButtonDidTouched(_ cell: SessionCollectionViewCell, isLiked: Bool) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        delegate?.likeButtonDidTouched(self, id: rooms[indexPath.row].sessionId, isLiked: isLiked)
    }
}
