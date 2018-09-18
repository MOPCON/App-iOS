//
//  News.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct News: Decodable {
    var payload: [Payload]
    
    struct Payload: Decodable {
        var id: String
        var time: String
        var title: String
        var description: String
        var link: String
    }
}
