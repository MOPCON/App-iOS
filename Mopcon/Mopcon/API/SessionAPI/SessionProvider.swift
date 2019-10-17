//
//  SessionProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/2.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class SessionProvider {
    
    static func fetchAllSession(completion: @escaping SessionListResultType) {
    
        HTTPClient.shared.request(
            SessionAPI.allSessions,
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
    
    static func fetchSession(id: Int, completion: @escaping RoomResultType) {
    
        HTTPClient.shared.request(
            SessionAPI.session(id),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let response = try JSONDecoder.shared.decode(SuccessResponse<Room>.self, from: data)
                        
                        completion(Result.success(response.data))
                    
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
}
