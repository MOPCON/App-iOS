//
//  Carousel.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Carousel: Decodable {
    var payload: [Payload]
    
    struct Payload: Decodable {
        var id: String?
        var title: String
        var banner: String
        var link: String
    }
}
