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

class Preference {
    class func load() -> String {
        if let preference = UserDefaults.standard.string(forKey: MPConstant.preference) {
            return preference
        } else {
            return ""
        }
    }
    
    class func store(_ preference: String) {
        UserDefaults.standard.setValue(preference, forKey: MPConstant.preference)
    }
}
