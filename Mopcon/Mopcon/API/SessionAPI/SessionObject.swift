//
//  SessionObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/2.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct SessionList: Codable {
    
    let date: Int
    
    let period: [Session]
}


struct Session: Codable {
    
    let startedAt: Int?
    
    let isBroadCast: Bool
    
    let endedAt: Int?
    
    let event: String
    
    let room: [Room]
    
    enum CodingKeys: String, CodingKey {
        
        case isBroadCast, event, room
        
        case startedAt = "started_at"
        
        case endedAt = "ended_at"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        startedAt = try? values.decode(Int.self, forKey: .startedAt)
        
        isBroadCast = try values.decode(Bool.self, forKey: .isBroadCast)
        
        endedAt = try? values.decode(Int.self, forKey: .endedAt)
        
        event = try values.decode(String.self, forKey: .event)
        
        do {
            
            room = try values.decode([Room].self, forKey: .room)
        
        } catch {
        
            room = []
        }
    }
}

struct Room: Codable {
    
    let topic: String
    
    let topicEn: String
    
    let summary: String
    
    let summaryEn: String
    
    let isKeynote: Bool
    
    let startedAt: Int
    
    let endedAt: Int
    
    let room: String
    
    let floor: String
    
    let sponsorId: Int
    
    let recordable: Bool
    
    let level: String
    
    let sessionId: Int
    
    let tags: [Tag]
    
    let sponsorInfo: SponsorInfo?
    
    let speakers: [SessionSpeaker]
    
    enum CodingKeys: String, CodingKey {
        
        case topic, summary, room, floor, recordable, level, tags, speakers
        
        case topicEn = "topic_e"
        
        case summaryEn = "summary_e"
        
        case isKeynote = "is_keynote"
        
        case startedAt = "started_at"
        
        case endedAt = "ended_at"
        
        case sponsorId = "sponsor_id"
        
        case sessionId = "session_id"
        
        case sponsorInfo = "sponsor_info"
    }
}

struct SponsorInfo: Codable {
    
    let name: String
    
    let nameEn: String
    
    let logo: String
    
    enum CodingKeys: String, CodingKey {
        
        case name
        
        case nameEn = "name_e"
        
        case logo = "logo_path"
    }
}

struct SessionSpeaker: Codable {
    
    let name: String
    
    let nameEn: String
    
    let speakerId: Int
    
    let company: String
    
    let companyEn: String
    
    let jobTitle: String
    
    let jobTitleEn: String
    
    enum CodingKeys: String, CodingKey {
        
        case name, company
        
        case nameEn = "name_e"
        
        case speakerId = "speaker_id"
        
        case companyEn = "company_e"
        
        case jobTitle = "job_title"
        
        case jobTitleEn = "job_title_e"
    }
}
