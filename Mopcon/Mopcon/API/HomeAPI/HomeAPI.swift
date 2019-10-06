//
//  HomeAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/25.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum HomeAPI: LKRequest {
    
    case home
    
    var endPoint: String {
        
        switch self {
            
        case .home: return "/api/2019/home"
        }
    }
}

