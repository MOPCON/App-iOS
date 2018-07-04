//
//  SponsorHeaderView.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SponsorHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    func updateUI(title:String){
        headerTitleLabel.text = title
    }
}
