//
//  Sponsor.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Sponsor: Decodable {
    var payload: [Payload]
    
    struct Payload: Decodable {
        var order: String
        var id: String
        var type: String
        var name: String
        var name_en: String
        var info: String
        var info_en: String
        var website: String
        var logo: String
        var liaison: String
        var remarks: String
    }
}
