//
//  URLExtension.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/10/3.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

extension URL {
    
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
