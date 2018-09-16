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
        var id: String
        var liasion: String
        var email: String
        var info: String
        var info_en: String
        var facebook: String
        var other_links: String
    }
}
