//
//  SessionAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/2.
//  Copyright © 2019 EthanLin. All rights reserved.
//

enum SessionAPI: LKRequest {
    
    case session
    
    var endPoint: String {
        
        switch self {
            
        case .session: return "/api/2019/session"
            
        }
    }
}
