//
//  UserDefaults.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/19.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class CurrentLanguage {
    class func getLanguage() -> String {
        if let language = UserDefaults.standard.string(forKey: "language") {
            return language
        } else {
            return "Chinese"
        }
    }
}
