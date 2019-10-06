//
//  UnConfProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/24.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class UnconfProvider {
    
    static func fetchUnConf(completion: @escaping SessionListResultType) {
    
        HTTPClient.shared.request(
            UnConfAPI.unconf,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let response = try JSONDecoder.shared.decode(SuccessResponse<[SessionList]>.self, from: data)
                        
                        completion(Result.success(response.data))
                    
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    static func fetchUnConfInfo(id: Int, completion: @escaping RoomResultType) {
    
        HTTPClient.shared.request(
            UnConfAPI.info(String(id)),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let response = try JSONDecoder.shared.decode(SuccessResponse<[Room]>.self, from: data)
                        
                        guard let info = response.data.first else {
                            
                        return completion(
                                Result.failure(
                                    NSError(
                                        domain: "",
                                        code: 999,
                                        userInfo: nil
                                    ) as Error
                                )
                            )
                        }
                        
                        completion(Result.success(info))
                    
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
}
