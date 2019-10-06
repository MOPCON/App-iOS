//
//  SpeakerAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/25.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum SpeakerAPI: LKRequest {
    
    case speakerList
    
    var endPoint: String {
        
        switch self {
            
        case .speakerList: return "/api/2019/speaker"
        }
    }
}
