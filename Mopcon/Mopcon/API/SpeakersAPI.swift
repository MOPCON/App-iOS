//
//  SpeakersAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class SpeakerAPI {
    
    class func getAPI(url:URL, completion: ((_ data:[Speaker.Payload]?,_ error:Error?) -> Void)?) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let speaker = try decoder.decode(Speaker.self, from: data)
                    completion?(speaker.payload,nil)
                } catch {
                    completion?(nil,error)
                }
            }
            }.resume()
    }
}
