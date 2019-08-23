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

class InitialProvider: MainThreadHelper {
    
    static func fetchInitialAPI(completion: @escaping (Result<SuccessConfig, Error>) -> Void) {
        
        HTTPClient.shared.request(InitialAPI.initial, completion: { result in
            
            switch result{
                
            case .success(let data):
                
                do {
                    
                    let config = try JSONDecoder.shared.decode(SuccessConfig.self, from: data)
                    
                    throwToMainThreadAsync {
                        
                        completion(Result.success(config))
                    }
                    
                } catch {
                    
                    completion(Result.failure(error))
                }
                
            case .failure(let error):
                
                completion(Result.failure(error))
            }
        })
    }
}
