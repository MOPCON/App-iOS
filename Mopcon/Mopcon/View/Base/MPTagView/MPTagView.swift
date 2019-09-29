//
//  MPTagView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/15.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol MPTagViewDataSource: AnyObject {
    
    func numberOfTags(_ tagView: MPTagView) -> Int
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor?
    
}

class MPTagView: UIView {

    weak var dataSource: MPTagViewDataSource? {
        
        didSet {
        
            colletionView.dataSource = self
        }
    }
    
    lazy var colletionView: UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.estimatedItemSize = CGSize(width: 46, height: 18)

        flowLayout.minimumLineSpacing = 6

        flowLayout.minimumInteritemSpacing = 0

        flowLayout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )

        flowLayout.scrollDirection = .horizontal

        let tempCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100),
            collectionViewLayout: flowLayout
        )

        tempCollectionView.register(
            TagViewCell.self,
            forCellWithReuseIdentifier: TagViewCell.identifier
        )

        addSubview(tempCollectionView)

        tempCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tempCollectionView.topAnchor.constraint(equalTo: topAnchor),
            tempCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tempCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tempCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        tempCollectionView.backgroundColor = UIColor.clear
        
        tempCollectionView.showsHorizontalScrollIndicator = false
        
        return tempCollectionView
    }()

    func reloadData() {
        
        colletionView.reloadData()
    }
}

extension MPTagView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource?.numberOfTags(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.identifier, for: indexPath)
        
        guard let tagViewCell = cell as? TagViewCell else { return cell }
        
        tagViewCell.label.text = dataSource?.titleForTags(self, index: indexPath.row)
        
        tagViewCell.backgroundColor = dataSource?.colorForTags(self, index: indexPath.row)
        
        return tagViewCell
    }
    
}

class TagViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupCell()
    }
    
    private func setupCell() {

        addSubview(label)

        label.font = UIFont.systemFont(ofSize: 10)

        label.textColor = UIColor.white

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor,  constant: -3)
        ])
        
        layer.cornerRadius = 3
        
        clipsToBounds = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let size = systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        
        var newFrame = layoutAttributes.frame
        
        newFrame.size = size
        
        layoutAttributes.frame = newFrame
        
        return layoutAttributes
    }
    
}
