//
//  UIImageExtension.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

enum ImageAsset: String {
    
    case lobby = "lobby"
    case lobbySelected = "lobby_selected"
    
    case schedual = "schedual"
    case schedualSelected = "schedual_selected"
    
    case mission = "mission"
    case missionSelected = "mission_selected"
    
    case news = "news"
    case newsSelected = "news_selected"
    
    case more = "more"
    case moreSelected = "more_selected"
    
    case communication = "communication"
    case speaker = "speaker"
    case sponsor = "sponsor"
    case group = "group"
    
    //Lobby
    case dislike_24 = "dislike_24"
    case like_24 = "like_24"
}

extension UIImage {
    
    class func asset(_ type: ImageAsset) -> UIImage? {
        
        return UIImage(named: type.rawValue)
    }
}


