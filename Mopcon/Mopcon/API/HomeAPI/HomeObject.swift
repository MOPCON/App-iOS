//
//  HomeObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/25.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class HomeProvider {

    static func fetchHome(completion: @escaping HomeResultType) {
        
        HTTPClient.shared.request(
            HomeAPI.home,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let response = try JSONDecoder.shared.decode(SuccessResponse<Home>.self, from: data)
                        
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
