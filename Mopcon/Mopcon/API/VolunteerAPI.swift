//
//  VolunteerAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/12.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class VolunteerAPI {
    
    class func getAPI(url:URL, completion: ((_ data:[Volunteer.Payload]?,_ error:Error?) -> Void)?) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let volunteer = try decoder.decode(Volunteer.self, from: data)
                    completion?(volunteer.payload,nil)
                } catch {
                    completion?(nil,error)
                }
            }
            }.resume()
    }
}
