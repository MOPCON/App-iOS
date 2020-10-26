//
//  Response.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct SuccessResponse<T: Codable>: Codable {
    
    let success: Bool
    
    let message: String
    
    let data: T
}

struct FailureResponse: Codable {
    
    let success: Bool
    
    let message: String
}

struct VersionResponse<T: Codable>: Codable {
    
    let results: [T]
}
