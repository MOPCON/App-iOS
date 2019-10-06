//
//  UserDefaults.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/19.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let dayOneSchedule = "2018-11-03"
    static let dayTwoSchedule = "2018-11-04"
    static let fcmToken = "fcmToken"
    static let UUID = "UUID"
}

class CurrentLanguage {
    class func getLanguage() -> String {
        if let language = UserDefaults.standard.string(forKey: "language") {
            return language
        } else {
            return "Chinese"
        }
    }
}
