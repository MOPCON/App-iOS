//
//  Carousel.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class CarouselAPI {
    
    class func getAPI(url:URL, completion: ((_ data:[Carousel.Payload]?,_ error:Error?) -> Void)?) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let carousel = try decoder.decode(Carousel.self, from: data)
                    completion?(carousel.payload,nil)
                } catch {
                    completion?(nil,error)
                }
            }
            }.resume()
    }
}
