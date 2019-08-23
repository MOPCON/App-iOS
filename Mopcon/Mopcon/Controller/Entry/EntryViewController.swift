//
//  EntryViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class EntryViewController: MPBaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        InitialProvider.fetchInitialAPI(completion: { result in
            
            switch result{
                
            case .success(let config):
                
                UserDefaults.standard.set(
                    config.data.apiServer.mopcon,
                    forKey: MPConstant.mopconServerKey
                )
                
                UserDefaults.standard.set(
                    config.data.apiServer.game,
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
                
            case .failure(let error):
                
                //TODO Error handle
                
                print(error)
                
            }
        })
        
    }
}
