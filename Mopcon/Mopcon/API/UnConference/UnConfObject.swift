//
//  UnConference.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/24.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

// MARK: - Datum
struct Datum: Codable {
    let date: Int
    let period: [Period]
}

// MARK: - Period
struct Period: Codable {
    let isBroadCast: Bool
    let startedAt, endedAt: Int
    let event: String
    let room: [Room]

    enum CodingKeys: String, CodingKey {
        case isBroadCast
        case startedAt = "started_at"
        case endedAt = "ended_at"
        case event, room
    }
}
