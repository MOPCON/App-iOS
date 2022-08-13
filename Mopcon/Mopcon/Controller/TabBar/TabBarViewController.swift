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

class TabBarViewController: UITabBarController, MainThreadHelper {
    
    private let tabs: [TabCategory] = [.lobby, .agenda, .fieldGame, .news, .more]
    
    private var hasShownAlert: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map{ tab in
            
            let vc = tab.instantiateInitialViewController()
            
            let tabBarItem = UITabBarItem(title: tab.title(), image: tab.image(), selectedImage: nil)
            
            vc.tabBarItem = tabBarItem
            
            return vc
        }
        
        tabBar.unselectedItemTintColor = .white
        
        tabBar.tintColor = UIColor.tabbarSelectedColor
        
        tabBar.barTintColor = UIColor.dark
        
        tabBar.isTranslucent = false
        
        if #available(iOS 13.0, *) {
            
            let appearance = UITabBarAppearance()
            
            appearance.shadowImage = nil
            
            appearance.shadowColor = nil
            
            if #available(iOS 15.0, *) {
                
                appearance.configureWithOpaqueBackground()
                
                appearance.backgroundColor = UIColor.dark
                
                tabBar.scrollEdgeAppearance = appearance
                
                tabBar.standardAppearance = appearance
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAppVersion()
    }
    
    private func checkAppVersion() {
        
        guard let info = Bundle.main.infoDictionary, let bundleID = info["CFBundleIdentifier"] as? String, let currentVersion = info["CFBundleShortVersionString"] as? String, !hasShownAlert else {
            
            return
        }
        
        InitialProvider.fetchAppVersion(of: bundleID, completion: { [weak self] result in
            
            switch result {
                
            case .success(let version):
                
                self?.throwToMainThreadAsync {
                    
                    if currentVersion != version.first?.version {
                        
                        self?.showVersionAlert()
                        
                        self?.hasShownAlert = true
                    }
                    
                }
                
            case .failure(let error):
                
                print(error)
            }

        })
    }
    
    private func showVersionAlert() {
        
        let alert = UIAlertController(title: "提示", message: "目前已有新版 App，請前往 AppStore 更新。", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "前往 AppStore", style: .default, handler: { _ in
            
            if let url = URL(string: MPConstant.mopconAppStore) {
                
                UIApplication.shared.open(url)
            }
        })
        
        alert.addAction(cancelAction)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
