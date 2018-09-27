//
//  File.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/25.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation


struct Quiz: Decodable {
    var date: String
    var items: [Item]
    
    struct Item: Decodable {
        var id: String
        var type: String
        var title: String
        var description: String?
        var options: [String]?
        var banner_url: String?
        var quiz: String?
        var answer: String?
        var status: String
        var unlock_time: String
    }
    
}
