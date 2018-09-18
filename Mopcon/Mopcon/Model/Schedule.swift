//
//  Schedule.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/14.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    var payload: Payload
    
    struct Payload: Codable {
        var agenda: [Agenda]
        var talk: [Talk]
        
        struct Agenda: Codable {
            var date: String
            var items:[Item]
            
            struct Item: Codable {
                var duration: String
                var agendas: [AgendaContent]
                
                struct AgendaContent: Codable {
                    var date: String?
                    var schedule_id: String?
                    var duration: String?
                    var location: String?
                    var speaker_id: String?
                    var name: String?
                    var name_en: String?
                    var type: String?
                    var company: String?
                    var job: String?
                    var info: String?
                    var info_en: String?
                    var picture: String?
                    var filename: String?
                    var facebook: String?
                    var github: String?
                    var blog: String?
                    var website: String?
                    var linkedin: String?
                    var category: String?
                    var degree_of_difficulty: String?
                    var schedule_topic: String?
                    var schedule_topic_en: String?
                    var schedule_info: String?
                    var schedule_info_en: String?
                    var characters: String?
                    var slide: String?
                    var picture_merged: String?
                    var video_record: String?
                }
            }
        }
        
        struct Talk: Codable {
            var date: String
            var items:[Item]
            
            struct Item: Codable {
                var duration: String
                var type: String
                var topic: String
                var speaker:String
            }
        }
    }
}
