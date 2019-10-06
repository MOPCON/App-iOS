//
//  HomeObject.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/25.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct Home: Codable {
    let banner: [Banner]
    let news: [HomeNews]
}

struct Banner: Codable {
    let img: String
    let link: String
}

// MARK: - News
struct HomeNews: Codable {
    let id, date: Int
    let title, description: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, date, title
        case description = "description"
        case link
    }
}
