//
//  InitialProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class InitialProvider: MainThreadHelper {
    
    static func fetchInitialAPI(completion: @escaping InitialResultType) {
        
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
    
    static func fetchAppVersion(of bundleID: String, completion: @escaping VersionResultType) {

        HTTPClient.shared.request(InitialAPI.version(bundleID), completion: { result in
            
            switch result{
                
            case .success(let data):
                  
                do{
                    
                    let successResponse = try JSONDecoder.shared.decode(
                        VersionResponse<Version>.self,
                        from: data
                    )
             
                    throwToMainThreadAsync {
                        
                        completion(Result.success(successResponse.results))
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
