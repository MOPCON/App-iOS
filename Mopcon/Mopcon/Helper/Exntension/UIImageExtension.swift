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
    
    case agenda = "agenda"
    case agendaSelected = "agenda_selected"
    
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
    
    //Base
    case back = "back"
    case close = "close"
    
    //Group
    case committee_team
    case agenda_team
    case finance_team
    case administrative_team
    case sponsor_team
    case into_team
    case art_team
    case public_team
    case place_team
    case record_team
    case video_team
    
    //Field Game
    case fieldGameProfile = "field_game_profile"
    
    //Speaker
    case iconFB = "icon-fb"
    case iconGithub = "icon-github"
    case iconTwitter = "icon-twitter"
}

extension UIImage {
    
    class func asset(_ type: ImageAsset) -> UIImage? {
        
        return UIImage(named: type.rawValue)
    }
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}


