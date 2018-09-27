//
//  User.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/26.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct User: Encodable {
    var publicKey: String
    var uuid: String
    var amount: Int?
    
    enum CodingKeys: String, CodingKey {
        case publicKey = "public_key"
        case uuid = "UUID"
        case amount
    }
    
    init(publicKey: String) {
        self.publicKey = publicKey
        self.uuid = UUID().uuidString
        self.amount = 0
    }
}
