//
//  EntryViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, MainThreadHelper {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkAppVersion()
    }
    
    private func register(with uid: String, and email: String) {
        
        FieldGameProvider.register(with: uid, and: email)
    }
    
    private func checkAppVersion() {
        
        guard let info = Bundle.main.infoDictionary, let bundleID = info["CFBundleIdentifier"] as? String, let currentVersion = info["CFBundleShortVersionString"] as? String else {
            
            return
        }
        
        InitialProvider.fetchAppVersion(of: bundleID, completion: { [weak self] result in
            
            switch result {
                
            case .success(let version):
                
                self?.throwToMainThreadAsync {
                    
                    if currentVersion != version.first?.version {

                        self?.showVersionAlert()
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
