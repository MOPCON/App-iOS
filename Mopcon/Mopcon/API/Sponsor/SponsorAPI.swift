//
//  SponsorAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum SponsorAPI: LKRequest {
    
    case sponsorList
    
    case sponsor(Int)
    
    var endPoint: String {
        
        switch self {
            
        case .sponsor, .sponsorList: return "/api/2022/sponsor"
        
        }
    }
    
    var queryString: [String : String] {
        
        switch self {
            
        case .sponsor(let id): return ["sponsor_id": String(id)]
            
        case .sponsorList: return [:]
        
        }
    }
}
