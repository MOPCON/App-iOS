//
//  LanguageCollectionViewCell.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/18.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class LanguageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chineseButton: CustomSelectedButton!
    @IBOutlet weak var englishButton: CustomSelectedButton!
    
    override func awakeFromNib() {
        if let language = UserDefaults.standard.string(forKey: "language") {
            switch language {
            case "Chinese":
                CommonFucntionHelper.changeButtonColor(beTappedButton: chineseButton, notSelectedButton: englishButton)
            case "English":
                CommonFucntionHelper.changeButtonColor(beTappedButton: englishButton, notSelectedButton: chineseButton)
            default:
                break
            }
        }
    }
    
    @IBAction func selectedChinese(_ sender: CustomSelectedButton) {
       CommonFucntionHelper.changeButtonColor(beTappedButton: chineseButton, notSelectedButton: englishButton)
    }
    
    @IBAction func selectedEnglish(_ sender: CustomSelectedButton) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: englishButton, notSelectedButton: chineseButton)
    }
    
}
