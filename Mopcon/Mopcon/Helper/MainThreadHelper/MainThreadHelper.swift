//
//  MainThreadHelper.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/23.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

protocol MainThreadHelper { }

extension MainThreadHelper {
    
    static func throwToMainThreadAsync(_ closure: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            closure()
        }
    }
}
