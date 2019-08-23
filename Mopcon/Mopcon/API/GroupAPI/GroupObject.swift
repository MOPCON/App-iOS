//
//  GroupObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    let communitys: [Community]
    
    let participants: [Participant]
    
    enum CodingKeys: String, CodingKey {
        
        case communitys = "community"
        
        case participants = "participant"
    }
}

struct Community: Codable {
    
    let id: String
    
    let name: String
    
    let photo: String
}

struct Participant: Codable {
    
    let id: String
    
    let name: String
    
    let photo: String
}

struct Organizer: Codable {
    
    let name: String
    
    let photo: String
    
    let introducion: String
    
    let introducionEn: String
    
    let facebook: String
    
    let twitter: String
    
    let instagram: String
    
    let telegram: String
    
    enum CondingKeys: String, CodingKey {
        
        case name, photom, introducion, facebook, twitter, instagram, telegram
        
        case introducionEn = "introducion_en"
    }
}
