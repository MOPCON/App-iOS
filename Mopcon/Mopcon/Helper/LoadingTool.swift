//
//  LoadingTool.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/28.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit
import Foundation

class LoadingTool {
    
    class func setActivityindicator() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return spinner
    }
}
