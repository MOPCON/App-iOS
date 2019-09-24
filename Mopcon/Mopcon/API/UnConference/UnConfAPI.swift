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
    
    var endPoint: String {
        
        switch self {
            
        case .unconf: return "/api/2019/unconf"
            
        }
    }
}
