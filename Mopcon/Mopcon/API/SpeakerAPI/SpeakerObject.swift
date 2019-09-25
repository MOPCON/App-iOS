//
//  SpeakerObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/25.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct Speaker: Codable {
    
    let name, nameEn: String
    let speakerID: Int
    let company, companyEn, jobTitle, jobTitleE: String
    let bio, bioEn: String
    let linkFb: String
    let linkGithub, linkTwitter: String
    let linkOther: String
    let topic, topicEn, summary, summaryEn: String
    let isKeynote: Bool
    let startedAt, endedAt: Int
    let room: String
    let floor: String
    let sponsorID: Int
    let recordable: Bool
    let level: String
    let sessionID: Int
    let img: SpeakerImage
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case name
        case nameEn = "name_e"
        case speakerID = "speaker_id"
        case company
        case companyEn = "company_e"
        case jobTitle = "job_title"
        case jobTitleE = "job_title_e"
        case bio
        case bioEn = "bio_e"
        case linkFb = "link_fb"
        case linkGithub = "link_github"
        case linkTwitter = "link_twitter"
        case linkOther = "link_other"
        case topic
        case topicEn = "topic_e"
        case summary
        case summaryEn = "summary_e"
        case isKeynote = "is_keynote"
        case startedAt = "started_at"
        case endedAt = "ended_at"
        case room, floor
        case sponsorID = "sponsor_id"
        case recordable, level
        case sessionID = "session_id"
        case img, tags
    }
}

