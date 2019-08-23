//
//  GroupProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class GroupProvider: MainThreadHelper {

    static func fetchCommunity(completion: @escaping CommunityResultType) {
        
        HTTPClient.shared.request(
            GroupAPI.community,
            completion: { result in
        
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<Group>.self,
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
            }
        )
    }
    
    static func fetchOrganizer(id: String, completion: @escaping OrganizerResultType) {
        
        HTTPClient.shared.request(
            GroupAPI.organizer(id),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<Organizer>.self,
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
            }
        )
    }
}
