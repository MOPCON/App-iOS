//
//  InitialAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum InitialAPI: LKRequest {
    
    case initial
    
    var baseURL: String {
        
        return MPConstant.baseURL
    }
    
    var endPoint: String {
        
        switch self {
        
        case .initial: return "/2019/initial"
            
        }
    }
}
