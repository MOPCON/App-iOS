//
//  TabViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

enum TabCategory: String {
    
    case lobby = "Lobby"
    case agenda = "Agenda"
    case missions = "Missions"
    case news = "News"
    case communication = "Communication"
    case speaker = "Speaker"
    case sponsor = "Sponsor"
    case group = "Group"

    func storyboard() -> UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateInitialViewController() -> UIViewController {
        
        guard let vc = storyboard().instantiateInitialViewController() else {
            
            return UIViewController()
        }
        
        //等到所有 tab 都完成，這邊就可以改成 return vc，不需要 switch case
        switch self {
            
        case .lobby, .agenda, .news, .speaker:
        
            return vc
            
        default: return UIViewController()
            
        }
    }
    
    func image() -> UIImage? {
        
        switch self {
        
        case .lobby: return UIImage.asset(.lobby)
            
        case .agenda: return UIImage.asset(.agenda)
            
        case .missions: return UIImage.asset(.mission)
            
        case .news: return UIImage.asset(.news)
            
        case .communication: return UIImage.asset(.communication)
            
        case .speaker: return UIImage.asset(.speaker)
            
        case .sponsor: return UIImage.asset(.sponsor)
            
        case .group: return UIImage.asset(.group)
            
        }
    }
    
    func seletedImage() -> UIImage? {
        
        switch self {
            
        case .lobby: return UIImage.asset(.lobbySelected)
            
        case .agenda: return UIImage.asset(.agendaSelected)
            
        case .missions: return UIImage.asset(.mission)
            
        case .news: return UIImage.asset(.newsSelected)
            
        case .communication: return UIImage.asset(.communication)
            
        case .speaker: return UIImage.asset(.speaker)
            
        case .sponsor: return UIImage.asset(.sponsor)
            
        case .group: return UIImage.asset(.group)
            
        }
    }
    
    func title() -> String {
        
        switch self {
            
        case .lobby: return "首頁"
            
        case .agenda: return "議程"
            
        case .missions: return "任務"
            
        case .news: return "最新"
            
        case .communication: return "交流場次"
            
        case .speaker: return "講者介紹"
            
        case .sponsor: return "贊助廠商"
            
        case .group: return "社群"
            
        }
    }
}

class TabBarViewController: UITabBarController {
    
    let tabs: [TabCategory] = [.lobby, .agenda, .missions, .news, .communication, .speaker, .sponsor, .group]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map{ tab in
            
            let vc = tab.instantiateInitialViewController()
            
            let tabBarItem = UITabBarItem(title: tab.title(), image: tab.image(), selectedImage: tab.seletedImage())
        
            vc.tabBarItem = tabBarItem
            
            return vc
        }
        
        tabBar.tintColor = UIColor.azure
        
        tabBar.barTintColor = UIColor.dark

        tabBar.isTranslucent = false
    }
}
