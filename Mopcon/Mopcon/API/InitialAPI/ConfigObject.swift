//
//  Config.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct SuccessConfig: Codable {
    
    let success: Bool
    
    let message: String
    
    let data: ServerState
}

struct ServerState: Codable {
    
    let apiServer: Server
    
    let isEnableGame: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case apiServer = "api_server"
        
        case isEnableGame = "enable_game"
    }
}

struct Server: Codable {
    
    let mopcon: String
    
    let game: String
}

