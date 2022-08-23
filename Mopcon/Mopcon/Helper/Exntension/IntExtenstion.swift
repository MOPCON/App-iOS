//
//  IntExtenstion.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2022/8/23.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import Foundation

extension Int {
    
    func makeWeekday() -> String {
        switch self {
        case 0: return "一"
        case 1: return "二"
        case 2: return "三"
        case 3: return "四"
        case 4: return "五"
        case 5: return "六"
        case 6: return "日"
        default: return ""
        }
        
    }
}
