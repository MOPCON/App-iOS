//
//  Schedule_unconf.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Schedule_unconf: Decodable {
    var payload: [Payload]
    
    struct Payload: Decodable {
        var date: String
        var items: [Item]
        
        struct Item: Decodable {
            var duration: String
            var type: String
            var topic: String
            var speaker: String
        }
    }
}
