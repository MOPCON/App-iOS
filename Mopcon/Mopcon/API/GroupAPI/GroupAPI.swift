//
//  GroupAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum GroupAPI: LKRequest {
    
    case community
    
    case organizer(String)
    
    case participant(Int)
    
    case volunteerList
    
    case volunteer(Int)
    
    var endPoint: String {
        
        switch self {
        
        case .community: return "/api/2022/community"
            
        case .organizer(let id): return "/api/2022/community/organizer/\(id)"
            
        case .participant(let id): return "/api/2022/community/participant/\(id)"
            
        case .volunteerList: return "/api/2022/volunteer"
            
        case .volunteer(let id): return "/api/2022/volunteer/\(id)"
            
        }
    }
}
