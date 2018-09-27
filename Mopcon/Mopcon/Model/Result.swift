//
//  Result.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/26.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Result: Decodable {
    var isSuccess: Bool?
    var balance: Int?
    var reward: Int?
    var id: Int?
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "is_success"
        case balance
        case reward
        case id
        case token
    }
    
}
