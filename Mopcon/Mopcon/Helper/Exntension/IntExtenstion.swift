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
        case 1: return "日"
        case 2: return "一"
        case 3: return "二"
        case 4: return "三"
        case 5: return "四"
        case 6: return "五"
        case 7: return "六"
        default: return ""
        }
        
    }
}
