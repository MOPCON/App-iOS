//
//  VolunteerObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct VolunteerList: Codable {
    
    let list: [List]
    
    enum CodingKeys: String, CodingKey {
        
        case list = "volunteer"
    }
}

struct List: Codable {
    
    let id: Int
    
    let name: String
    
    let photo: String
}

struct Volunteer: Codable {
    
    let name: String
    
    let photo: String
    
    let members: [String]
    
    let introduction: String
    
    let introductionEn: String
    
    enum CodingKeys: String, CodingKey {
        
        case name, photo, members
    
        case introductionEn = "introduction_e"
    
        case introduction = "introduction"
    }
}
