//
//  MPTagView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/15.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

enum TagViewType {
    
    case solid
    
    case hollow
}

protocol MPTagViewDataSource: AnyObject {
    
    func numberOfTags(_ tagView: MPTagView) -> Int
    
    func viewType(_ tagView: MPTagView, index: Int) -> TagViewType
    
    func titleForTags(_ tagView: MPTagView, index: Int) -> String
    
    func colorForTags(_ tagView: MPTagView, index: Int) -> UIColor?
    
}

extension MPTagViewDataSource {
    
    func viewType(_ tagView: MPTagView, index: Int) -> TagViewType {
        
        return .solid
    }
}

class MPTagView: UIView {
    
    weak var dataSource: MPTagViewDataSource? {
        
        didSet {
        
            colletionView.dataSource = self
            
            colletionView.delegate = self
        }
    }
    
    lazy var colletionView: UICollectionView = {

        let flowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        
        flowLayout.estimatedItemSize = CGSize(width: 46, height: 20)

        flowLayout.minimumLineSpacing = 6

        flowLayout.minimumInteritemSpacing = 6

//        flowLayout.scrollDirection = .horizontal
        
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

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        
        guard let tagViewCell = cell as? TagViewCell,
              let dataSource = dataSource
        else {
            
            return cell
        }
        
        tagViewCell.label.text = dataSource.titleForTags(self, index: indexPath.row)

        switch dataSource.viewType(self, index: indexPath.row) {
            
        case .hollow:
            
            tagViewCell.backgroundColor = UIColor.clear
            
            tagViewCell.label.textColor = dataSource.colorForTags(self, index: indexPath.row)
            
            tagViewCell.layer.borderColor = dataSource.colorForTags(self, index: indexPath.row)?.cgColor
            
            tagViewCell.layer.borderWidth = 1
            
        case .solid:
        
            tagViewCell.backgroundColor = UIColor.tagBackgroundColor
        
            tagViewCell.label.textColor = UIColor.tagTextColor
            
            tagViewCell.layer.borderColor = UIColor.clear.cgColor
            
            tagViewCell.layer.borderWidth = 0
        }
        
        return tagViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let rightPadding = CGFloat(((dataSource?.numberOfTags(self) ?? 0) - 1) * 3)

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
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
        
        layer.cornerRadius = frame.height * 0.5
        
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
