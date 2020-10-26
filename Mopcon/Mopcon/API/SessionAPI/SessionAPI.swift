//
//  SessionAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/2.
//  Copyright © 2019 EthanLin. All rights reserved.
//

enum SessionAPI: LKRequest {
    
    case session(Int)
    
    case allSessions
    
    var endPoint: String {
        
        switch self {
            
        case .allSessions: return "/api/2020/session"
            
        case .session(let id): return "/api/2020/session/\(id)"
        }
    }
}
