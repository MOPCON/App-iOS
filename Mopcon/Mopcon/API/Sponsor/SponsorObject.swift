//
//  SponsorObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct SponsorList: Codable {
    
    let name: String
    
    let nameEn: String
    
    let data: [Sponsor]
    
    enum CodingKeys: String, CodingKey {

        case name, data

        case nameEn = "name_e"
    }
}

struct Sponsor: Codable {
    
    let logo: String
    
    let name: String
    
    let nameEn: String
    
    let sponsorId: String
    
    let aboutUs: String
    
    let aboutUsEn: String
    
    let facebook: String
    
    let officialWebsite: String
    
    let careerInformation: String
    
    let sponsorType: String
    
    let speakerInfo: [SponsorSpeaker]
    
    enum CodingKeys: String, CodingKey {
        
        case name
        
        case logo = "logo_path"
        
        case nameEn = "name_e"
        
        case sponsorId = "sponsor_id"
        
        case aboutUs = "about_us"
        
        case aboutUsEn = "about_us_e"
        
        case facebook = "facebook_url"
        
        case officialWebsite = "official_website"
        
        case careerInformation = "career_information"
        
        case sponsorType = "sponsor_type"
        
        case speakerInfo = "speaker_information"
    }
}

struct SponsorSpeaker: Codable {
    
    let img: SpeakerImage
    
    let speakerId: Int
    
    let sessionId: Int
    
    let name: String
    
    let nameEn: String
    
    let topicName: String
    
    let topicNameEn: String
    
    let startedAt: Int
    
    let endedAt: Int
    
    let room: String
    
    let tags: [Tag]
    
    enum CodingKeys: String, CodingKey {
        
        case img, name, room, tags
        
        case speakerId = "speaker_id"
        
        case sessionId = "session_id"
        
        case nameEn = "name_e"
        
        case topicName = "topic_name"
        
        case topicNameEn = "topic_name_e"
        
        case startedAt = "started_at"
        
        case endedAt = "endeded_at"
    }
}

struct SpeakerImage: Codable {
    
    let web: String
    
    let mobile: String
}

struct Tag: Codable {
    
    let color: String
    
    let name: String
}
