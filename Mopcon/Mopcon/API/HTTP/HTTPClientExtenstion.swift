//
//  HTTPClientExtenstion.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

extension LKRequest {
    
    var baseURL: String {
        
        return UserDefaults.standard.string(forKey: MPConstant.mopconServerKey)!
    }
    
    var headers: [String : String] { return [:] }
    
    var body: Data? { return nil }
    
    var method: String { return LKHTTPMethod.get.rawValue }
}
