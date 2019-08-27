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
    
    case participant(String)
    
    case volunteerList
    
    case volunteer(String)
    
    var endPoint: String {
        
        switch self {
        
        case .community: return "/api/2019/community"
            
        case .organizer(let id): return "/api/2019/community/organizer/\(id)"
            
        case .participant(let id): return "/api/2019/community/participant/\(id)"
            
        case .volunteerList: return "/api/2019/volunteer"
            
        case .volunteer(let id): return "/api/2019/volunteer/\(id)"
            
        }
    }
}
