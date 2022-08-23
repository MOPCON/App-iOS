//
//  UITableViewCellExtension.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2022/8/23.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func addCustomDisclosureIndicator(with color: UIColor) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .large)
        let symbolImage = UIImage(systemName: "chevron.right",
                                  withConfiguration: symbolConfig)
        button.setImage(symbolImage?.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        button.tintColor = color
        self.accessoryView = button
    }
}

