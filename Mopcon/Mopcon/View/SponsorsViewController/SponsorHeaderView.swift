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
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    func updateIcon(section:NSInteger)
    {
        switch section {
        case 0:
            self.iconImageView.image =  UIImage.asset(.sponsor01)
            break;
        case 1:
            self.iconImageView.image =  UIImage.asset(.sponsor02)
            break;
        case 2:
            self.iconImageView.image =  UIImage.asset(.sponsor03)
            break;
        case 3:
            self.iconImageView.image =  UIImage.asset(.sponsor04)
            break;
        case 4:
            self.iconImageView.image =  UIImage.asset(.sponsor05)
            break;
        case 5:
            self.iconImageView.image =  UIImage.asset(.sponsor06)
            break;
        default:
            break;
        }
    }
    
    
    func updateUI(section:NSInteger, title:String){
        headerTitleLabel.text = title
        headerTitleLabel.textColor = UIColor.secondThemeColor
        self.updateIcon(section: section)
    }
}
