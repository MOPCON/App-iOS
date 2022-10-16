//
//  LobbyBannerCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol LobbyBannerCellDelegate: AnyObject {

    func didSelectedIndex(_ cell: LobbyBannerCell, index: Int)
}

class LobbyBannerCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageUrls: [String] = [] {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: LobbyBannerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(
            LobbyBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: LobbyBannerCollectionViewCell.identifier
        )
    }
}

extension LobbyBannerCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LobbyBannerCollectionViewCell.identifier,
            for: indexPath
        )
        
        guard let bannerCell = cell as? LobbyBannerCollectionViewCell else { return cell }
        
        bannerCell.imageView.loadImage(imageUrls[indexPath.row])
        
        return cell
    }
}

extension LobbyBannerCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
    
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectedIndex(self, index: indexPath.row)
    }
}

private class LobbyBannerCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func setup() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        imageView.layer.cornerRadius = 6.0
        
        imageView.clipsToBounds = true
        
        imageView.backgroundColor = UIColor.clear
        
        imageView.contentMode = .scaleAspectFill
    }
}
