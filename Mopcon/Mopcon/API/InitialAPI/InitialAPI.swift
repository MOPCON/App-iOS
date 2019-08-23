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
    
    var endPoint: String {
        
        switch self {
        
        case .initial: return "/2019/initial"
            
        }
    }
}

class InitialProvider {
    
    static func fetchInitialAPI() {
        
        HTTPClient.shared.request(InitialAPI.initial, completion: { result in
            
            switch result{
                
            case .success(let data):
                
                print(data)
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}
