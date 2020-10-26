//
//  UnConfAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/24.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum UnConfAPI: LKRequest {
    
    case unconf
    
    case info(String)
    
    var endPoint: String {
        
        switch self {
            
        case .unconf: return "/api/2020/unconf"
            
        case .info(let id): return "/api/2020/unconf/\(id)"
            
        }
    }
}
