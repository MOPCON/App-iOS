//
//  NewsProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/29.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class NewsProvider {
    
    static func fetchNews(completion: @escaping NewsListResultType) {
        
        HTTPClient.shared.request(
            NewsAPI.news,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let response = try JSONDecoder.shared.decode(SuccessResponse<[News]>.self, from: data)
                        
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
