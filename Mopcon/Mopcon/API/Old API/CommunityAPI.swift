//
//  CommunityAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/15.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class CommunityAPI {
    
//    class func getAPI(url:URL, completion: ((_ data:[Community.Payload]?,_ error:Error?) -> Void)?) {
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//            
//            if let data = data {
//                let decoder = JSONDecoder()
//                do {
//                    let community = try decoder.decode(Community.self, from: data)
//                    completion?(community.payload,nil)
//                } catch {
//                    completion?(nil,error)
//                }
//            }
//            }.resume()
//    }
}
