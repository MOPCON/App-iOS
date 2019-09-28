//
//  LobbyNewsCell.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class LobbyNewsCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!
    
    @IBOutlet weak var showMoreButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(
            LobbyNewsCollectionViewCell.self,
            forCellWithReuseIdentifier: LobbyNewsCollectionViewCell.identifier
        )
    }
    
    @IBAction func showMore() {
        
    }
}

extension LobbyNewsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LobbyNewsCollectionViewCell.identifier,
            for: indexPath
        )
        
        guard let newsCell = cell as? LobbyNewsCollectionViewCell else { return cell }
        
        newsCell.label.text = "下午茶時間到了！有好多點心跟飲料，不要錯過唷！下午茶時間到了！有好多點心跟飲料，不要錯過唷！下午茶時間到了！有好多點心跟飲料，不要錯過唷！"
        
        return cell
    }
}

extension LobbyNewsCell: UICollectionViewDelegateFlowLayout {
    
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
        
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 0
    }
}

private class LobbyNewsCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func setup() {
        
        backgroundColor = UIColor.azure?.withAlphaComponent(0.2)
        
        layer.cornerRadius = 6.0
        
        clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18)
        ])
        
        label.backgroundColor = UIColor.clear
        
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.textColor = UIColor.white
        
        label.numberOfLines = 0
    }
}
