//
//  TabViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

private enum TabCategory: String {
    
    case lobby = "Lobby"
    case agenda = "Agenda"
    case fieldGame = "FieldGame"
    case news = "News"
    case more = "More"
    
    func storyboard() -> UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateInitialViewController() -> UIViewController {
        
        guard let vc = storyboard().instantiateInitialViewController() else {
            
            return UIViewController()
        }
        
        //等到所有 tab 都完成，這邊就可以改成 return vc，不需要 switch case
        
        return vc
    }
    
    func image() -> UIImage? {
        
        switch self {
        
        case .lobby: return UIImage.asset(.lobby)
            
        case .agenda: return UIImage.asset(.agenda)
            
        case .fieldGame: return UIImage.asset(.mission)
            
        case .news: return UIImage.asset(.news)
            
        case .more: return UIImage.asset(.more)
            
        }
    }
    
    func title() -> String {
        
        switch self {
            
        case .lobby: return "首頁"
            
        case .agenda: return "議程"
            
        case .fieldGame: return "任務"
            
        case .news: return "最新"
            
        case .more: return "更多"
            
        }
    }
}

class TabBarViewController: UITabBarController {
    
    private let tabs: [TabCategory] = [.lobby, .agenda, .fieldGame, .news, .more]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map{ tab in
            
            let vc = tab.instantiateInitialViewController()
            
            let tabBarItem = UITabBarItem(title: tab.title(), image: tab.image(), selectedImage: nil)
        
            vc.tabBarItem = tabBarItem
            
            return vc
        }
        
        tabBar.unselectedItemTintColor = .white
        
        tabBar.tintColor = UIColor.secondThemeColor
        
        tabBar.barTintColor = UIColor.dark

        tabBar.isTranslucent = false
    }
}
