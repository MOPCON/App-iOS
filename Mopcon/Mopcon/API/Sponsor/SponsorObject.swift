//
//  SponsorObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct SponsorList: Codable {
    
    var tonyStark: [Sponsor]?

    var bruceWayne: [Sponsor]?
    
    var hacker: [Sponsor]?

    var geek: [Sponsor]?
    
    var developer: [Sponsor]?

    var specialCooperation: [Sponsor]?

    var specialThanks: [Sponsor]?

    var education: [Sponsor]?
    
    enum CodingKeys: String, CodingKey {

        case tonyStark = "tony_stark"

        case bruceWayne = "bruce_wayne"

        case specialCooperation = "special_cooperation"

        case specialThanks = "special_thanks"

        case hacker, geek, developer, education
    }
}

struct Sponsor: Codable {
    
    let logo: String
    
    let sponsor: String
    
    let sponsorEn: String
    
    let sponsorId: String
    
    let aboutUs: String
    
    let aboutUsEn: String
    
    let facebook: String?
    
    let officialWebsite: String?
    
    let careerInformation: String?
    
    let sponsorType: String
    
    let speakerInformation: [SponsorSperker]?
    
    enum CodingKeys: String, CodingKey {
        
        case logo = "logo_path"
        
        case sponsorEn = "sponsor_en"
        
        case sponsorId = "sponsor_id"
        
        case aboutUs = "about_us"
        
        case aboutUsEn = "about_us_en"
        
        case facebook = "facebook_url"
        
        case officialWebsite = "official_website"
        
        case careerInformation = "career_information"
        
        case sponsorType = "sponsor_type"
        
        case speakerInformation = "speaker_information"
        
        case sponsor
    }
}

struct SponsorSperker: Codable {
    
    let img: SpeakerImage
    
    let name: String
    
    let nameEn: String
    
    let title: String
    
    let titleEn: String
    
    let startedAt: Int
    
    let endedAt: Int
    
    let room: String
    
    enum CodingKeys: String, CodingKey {
        
        case title = "speaker_title"
        
        case room = "speaker_room"
        
        case name = "speaker_name"
        
        case img = "speaker_img"
        
        case nameEn = "speaker_name_en"
        
        case titleEn = "title_e"
        
        case startedAt = "started_at"
        
        case endedAt = "ended_at"
    }
}

struct SpeakerImage: Codable {
    
    let web: String
    
    let mobile: String
}

struct Tag: Codable {
    
}
