//
//  Speaker.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

struct Speaker: Decodable {
    var payload: [Payload]
    
    struct Payload: Decodable {
        var speaker_id: String
        var name: String
        var name_en: String
        var type: String
        var company: String
        var job: String
        var info: String
        var info_en: String
        var picture: String
        var filename: String
        var facebook: String
        var github: String
        var blog: String
        var website: String
        var linkedin: String
        var schedule_topic: String
        var schedule_topic_en: String
        var schedule_info: String
        var schedule_info_en: String
        var characters: String
        var schedule_id: String
        var slide: String
        var picture_merged: String
        var video_record: String
    }
}

enum SpeakerTag: String {
    
    case blockchain = "Blockchain"

    case design = "Design"
    
    case ioT = "IoT"
    
    var color: UIColor? {
        
        switch self {
            
        case .blockchain: return UIColor.azureTwo
            
        case .design: return UIColor.barbiePink
            
        case .ioT: return UIColor.greenTwo
            
        }
    }
}
