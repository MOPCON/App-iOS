//
//  NewsAPI.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/29.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum NewsAPI: LKRequest {
    
    case news
    
    var endPoint: String {
        
        switch self {
            
        case .news: return "/api/2020/news"
        }
    }
}
