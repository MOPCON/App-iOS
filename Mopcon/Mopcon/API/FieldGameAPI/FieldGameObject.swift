//
//  FieldGameObject.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/9/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct Auth: Codable {
    
    let accessToken: String
    
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "access_token"
        
        case tokenType = "token_type"        
    }
}

struct FieldGameIntro: Codable {
    
    let image: String
    
    let title: String
    
    let titleEn: String
    
    let description: String
    
    let descriptionEn: String
    
    enum CodingKeys: String, CodingKey {
        
        case image, title, description
        
        case titleEn = "title_e"
        
        case descriptionEn = "description_e"
    }
}

struct FieldGameMe: Codable {
    
    let uid: String
    
    let missions: [Mission]
    
    let rewards: [Reward]
    
    let wonPoint: Int
    
    enum CodingKeys: String, CodingKey {
        
        case uid
        
        case missions = "mission_list"
        
        case rewards = "reward_list"
        
        case wonPoint = "won_point"
    }
}

struct FieldGameTask: Codable {
    
    let uid: String
    
    let name: String
    
    let nameEn: String
    
    let description: String
    
    let descriptionEn: String
    
    let image: String
    
    enum CodingKeys: String, CodingKey {
        
        case uid, name, description, image
        
        case nameEn = "name_e"
        
        case descriptionEn = "description_e"
    }
}

struct FieldGameReward: Codable {
    
    let uid: String
    
    let name: String
    
    let nameEn: String
    
    let description: String
    
    let descriptionEn: String
    
    let image: String
    
    enum CodingKeys: String, CodingKey {
        
        case uid, name, description, image
        
        case nameEn = "name_e"
        
        case descriptionEn = "description_e"
    }
}

struct Mission: Codable {
    
    let uid: String
    
    let name: String
    
    let nameEn: String
    
    let description: String?
    
    let descriptionEn: String?
    
    let open: Int
    
    let point: Int
    
    let order: Int
    
    var pass: Int
    
    let task: Task?
    
    enum CodingKeys: String, CodingKey {
        
        case uid, name, description, open, point, order, pass, task
        
        case nameEn = "name_e"
        
        case descriptionEn = "description_e"
    }
}

struct Task: Codable {
    
    let uid: String
    
    let missionUid: String
    
    let name: String
    
    let nameEn: String
    
    let description: String
    
    let descriptionEn: String
    
    let image: String
    
    enum CodingKeys: String, CodingKey {
        
        case uid, name, description, image
        
        case missionUid = "mission_uid"
        
        case nameEn = "name_e"
        
        case descriptionEn = "description_e"
    }
}

struct Reward: Codable {
    
    let uid: String
    
    let name: String
    
    let nameEn: String
    
    let description: String?
    
    let descriptionEn: String?
    
    let image: String
    
    let redeemable: Int
    
    let redeemed: Int
    
    let hasWon: Int
    
    enum CodingKeys: String, CodingKey {
        
        case uid, name, description, image, redeemable, redeemed
        
        case nameEn = "name_e"
        
        case descriptionEn = "description_e"
        
        case hasWon = "has_won"
    }
}
