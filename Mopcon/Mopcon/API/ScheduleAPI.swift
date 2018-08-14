//
//  ScheduleAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class ScheduleAPI {
    
    class func getAPI(url:URL, completion: ((_ data:Schedule.Payload?,_ error:Error?) -> Void)?) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let schedule = try decoder.decode(Schedule.self, from: data)
                    completion?(schedule.payload,nil)
                } catch {
                    completion?(nil,error)
                }
            }
            }.resume()
    }
}
