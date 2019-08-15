//
//  MopconBaseViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/15.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class MPBaseViewController: UIViewController {
    
    var isModifyBackButton: Bool {
        
        return true
    }
    
    var isModifyBackItemTitle: Bool {
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isModifyBackItemTitle {
            
            modifyBackItemTitle()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isModifyBackButton {
            
            modifyBackButton()
        }
    }
    
    private func modifyBackItemTitle() {
            
        let backItemButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
        
        navigationItem.backBarButtonItem = backItemButton
    }
    
    private func modifyBackButton() {
        
        navigationController?.navigationBar.backIndicatorImage = UIImage.asset(.back)
        
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.asset(.back)
    }
    
}
