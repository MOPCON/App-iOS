//
//  InformationCollectionViewCell.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/10/2.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

protocol InformationCollectionViewCellDelegate: class {
    func exchange(amount: Int)
}

class InformationCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: InformationCollectionViewCellDelegate?
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var capsulesLabel: UILabel!
    @IBOutlet weak var exchangeButton: UIButton!
    
    @IBAction func exchange(_ sender: Any) {
        if let text = balanceLabel.text, let amount = Int(text) {
            delegate?.exchange(amount: amount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
        self.clipsToBounds = true
    }
    
    func update(balance: Int) {
        self.balanceLabel.text = "\(balance)"
        self.capsulesLabel.text = "\(balance / 200)"
        
        if balance >= 200 {
            exchangeButton.alpha = 1
            exchangeButton.isUserInteractionEnabled = true
        } else {
            exchangeButton.alpha = 0.3
            exchangeButton.isUserInteractionEnabled = false
        }
    }
    
}
