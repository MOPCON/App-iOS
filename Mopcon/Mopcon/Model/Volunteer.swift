//
//  Volunteer.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/12.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

struct Volunteer: Decodable {
    
    var payload: [Payload]
   
    struct Payload: Decodable {
        
        var id:String
        var groupname: String
        var groupname_en: String
        var info: String
        var info_en: String
        var memberlist: String

        func image() -> UIImage? {
            
            switch groupname {
                
            case "議程委員會": return UIImage.asset(.committee_team)
                
            case "行政組": return UIImage.asset(.administrative_team)
                
            case "議程組": return UIImage.asset(.agenda_team)
            
            case "財務組": return UIImage.asset(.finance_team)
                
            case "贊助組": return UIImage.asset(.sponsor_team)
                
            case "公關組": return UIImage.asset(.public_team)
                
            case "資訊組": return UIImage.asset(.into_team)
                
            case "美術組": return UIImage.asset(.art_team)
                
            case "紀錄組": return UIImage.asset(.record_team)
                
            case "錄影組": return UIImage.asset(.video_team)
                
            case "場務組": return UIImage.asset(.place_team)
                
            default: return nil
                
            }
        }
    }
}
