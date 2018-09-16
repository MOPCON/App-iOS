//
//  Volunteer.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/12.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Volunteer: Decodable {
    var payload: [Payload]
   
    struct Payload: Decodable {
        var id:String
        var groupname: String
        var groupname_en: String
        var info: String
        var info_en: String
        var memberlist: String
    }
    
}
