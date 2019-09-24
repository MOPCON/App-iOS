//
//  UnConferenceViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/24.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class UnConferenceViewController: MPBaseSessionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UnconfProvider.fetchUnConf(completion: { result in
            
            switch result {
                
            case .success(let list):
                
                break
                
            case .failure(let error):
                
                break
                
            }
            
        })
    }
}
