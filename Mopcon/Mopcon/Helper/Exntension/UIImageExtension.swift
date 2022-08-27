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
    
    case agenda = "agenda"
    
    case mission = "mission"
    
    case news = "news"
    
    case more = "more"
    
    case communication = "communication"
    case speaker = "speaker"
    case sponsor = "sponsor"
    case group = "group"
    
    //Lobby
    case dislike = "dislike"
    case like = "like"
    
    //Base
    case back = "back"
    case close = "close"
    
    //Group
    case committee_team
    case agenda_team
    case finance_team
    case administrative_team
    case sponsor_team
    case info_team
    case art_team
    case public_team
    case place_team
    case record_team
    case video_team
    
    //Field Game
    case fieldGameProfile = "field_game_profile"
    
    //Speaker
    case iconFB = "icon_fb"
    case iconGithub = "icon_github"
    case iconTwitter = "icon_twitter"
    case iconWebsite = "icon_website"
    case coverImage = "coverImage"
    case bgImage = "bgImage"
    
    //SposorType
    case sponsor01 = "sponsor01"
    case sponsor02 = "sponsor02"
    case sponsor03 = "sponsor03"
    case sponsor04 = "sponsor04"
    case sponsor05 = "sponsor05"
    case sponsor06 = "sponsor06"
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


