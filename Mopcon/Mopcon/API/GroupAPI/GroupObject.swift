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
    
    let id: Int
    
    let name: String
    
    let photo: String
}

struct Participant: Codable {
    
    let id: Int
    
    let name: String
    
    let photo: ParticipanterImage
}

struct Organizer: Codable {
    
    let name, nameEn: String
    let photo: String
    let introduction, introductionEn: String
    let facebook: String
    let twitter, instagram, telegram, event: String

    enum CodingKeys: String, CodingKey {
        case name
        case nameEn = "name_e"
        case photo, introduction
        case introductionEn = "introduction_e"
        case facebook, twitter, instagram, telegram, event
    }
}

struct Participanter: Codable {
    
    let name, nameEn: String
    let photo: ParticipanterImage
    let introduction, introductionEn: String
    let facebook: String
    let twitter, instagram, telegram, event: String

    enum CodingKeys: String, CodingKey {
        case name
        case nameEn = "name_e"
        case photo, introduction
        case introductionEn = "introduction_e"
        case facebook, twitter, instagram, telegram, event
    }
}


struct ParticipanterImage: Codable {
    
    let web: String
    
    let mobile: String
}
