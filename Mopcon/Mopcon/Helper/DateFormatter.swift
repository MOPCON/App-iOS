//
//  DateFormatter.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/20.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    private static let shared = DateFormatter()
    
    static func string(for date: Date, formatter: String) -> String {
        
        DateFormatter.shared.dateFormat = formatter
        
        return DateFormatter.shared.string(from: date)
    }
    
    static func string(for timeInterval: Int?, formatter: String) -> String? {
        
        guard let interval = timeInterval else { return nil }
        
        let date = Date(timeIntervalSince1970: Double(interval))
        
        return string(for: date, formatter: formatter)
    }
}
