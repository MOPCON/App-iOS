//
//  InitialProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class InitialProvider: MainThreadHelper {
    
    static func fetchInitialAPI(completion: @escaping (Result<ServerState, Error>) -> Void) {
        
        HTTPClient.shared.request(InitialAPI.initial, completion: { result in
            
            switch result{
                
            case .success(let data):
                
                do {
                    
                    let successResponse = try JSONDecoder.shared.decode(
                        SuccessResponse<ServerState>.self,
                        from: data
                    )
                    
                    throwToMainThreadAsync {
                        
                        completion(Result.success(successResponse.data))
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
