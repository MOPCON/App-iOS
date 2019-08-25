//
//  SponsorProvider.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class SponsorProvider {
    
    static func fetchSponsor(id: String? = nil, completion: @escaping SponsorResultType) {
        
        HTTPClient.shared.request(
            SponsorAPI.sponsor(id),
            completion: { result in
                
                switch result{
                    
                case .success:
                    
                    print(123)
                    
                case .failure:
                    
                    print(456)
                }
            }
        )
    }
    
}
