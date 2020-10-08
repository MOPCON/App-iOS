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
    
    case version(String)
    
    var baseURL: String {
        
        switch self {
            
        case .initial: return MPConstant.baseURL
            
        case .version: return MPConstant.itunesURL
        
        }
    }
    
    var endPoint: String {
        
        switch self {
        
        case .initial: return "/api/2020/initial"
            
        case .version(let bundleID): return bundleID
            
        }
    }
}
