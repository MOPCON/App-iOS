//
//  Community.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Community: Decodable {
    var payload: [Payload]
    
    struct Payload: Decodable {
        var title: String
        var liasion: String
        var email: String?
        var name: String
        var name_en: String
        var info: String
    }
}
