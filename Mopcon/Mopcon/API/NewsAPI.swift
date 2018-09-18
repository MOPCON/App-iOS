//
//  NewsAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/17.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class NewsAPI {
    
    class func getAPI(url:URL, completion: ((_ data:[News.Payload]?,_ error:Error?) -> Void)?) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let news = try decoder.decode(News.self, from: data)
                    completion?(news.payload,nil)
                } catch {
                    completion?(nil,error)
                }
            }
            }.resume()
    }
}
