//
//  SegmentedControl.swift
//  Mopcon
//
//  Created by 詹欣達 on 2020/8/15.
//  Copyright © 2020 EthanLin. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    override func awakeFromNib() {
        super.awakeFromNib()

        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainThemeColor!], for: .selected)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.secondThemeColor!], for: .normal)
    }
}
