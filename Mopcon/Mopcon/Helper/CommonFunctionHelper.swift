//
//  CommonFunctionHelper.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation
import UIKit

struct CommonFucntionHelper {
    static func changeButtonColor(beTappedButton:CustomSelectedButton, notSelectedButton:CustomSelectedButton){
        beTappedButton.backgroundColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.2)
        beTappedButton.setTitleColor(UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 1), for: .normal)
        beTappedButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        notSelectedButton.backgroundColor = UIColor.clear
        notSelectedButton.setTitleColor(UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.5), for: .normal)
    }
}
