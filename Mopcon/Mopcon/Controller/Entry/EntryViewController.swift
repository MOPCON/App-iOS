//
//  EntryViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        InitialProvider.fetchInitialAPI(completion: { [weak self] result in
            
            switch result{
                
            case .success(let serverState):
                
                UserDefaults.standard.set(
                    serverState.apiServer.game,
                    forKey: MPConstant.gameServerKey
                )
                
                guard let window = UIApplication.shared.keyWindow else { return }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let tabVC = storyboard.instantiateViewController(withIdentifier: TabBarViewController.identifier)
                
                UIView.transition(
                    with: window,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: {
                        
                        window.rootViewController = tabVC
                    
                    },
                    completion: nil
                )
                
                if let tabBarController = tabVC as? UITabBarController {
                    
                    if let items = tabBarController.tabBar.items {
                        items[2].isEnabled = serverState.isEnableGame
                    }
                }
                                
                if !UserDefaults.standard.bool(forKey: "hasOpened") {
                    
                    UserDefaults.standard.set(true, forKey: "hasOpened")
                    
                    guard KeychainTool.retrive(for: "token") == nil else { break }
                    
                    let uuid = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
                    
                    self?.register(with: uuid, and: uuid)
                }
                
            case .failure(let error):
                
                //TODO Error handle
                
                print(error)
                
            }
        })
    }
    
    private func register(with uid: String, and email: String) {
        
        FieldGameProvider.register(with: uid, and: email)
    }
}
