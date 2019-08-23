//
//  Schedule_unconfAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/15.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class Schedule_unconfAPI {
    
    class func getAPI(url:URL, completion: ((_ data:[Schedule_unconf.Payload]?,_ error:Error?) -> Void)?) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let schedule = try decoder.decode(Schedule_unconf.self, from: data)
                    completion?(schedule.payload,nil)
                } catch {
                    completion?(nil,error)
                }
            }
            }.resume()
    }
}
