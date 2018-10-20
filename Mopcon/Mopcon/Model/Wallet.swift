//
//  Wallet.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/10/21.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation

struct Wallet {
    
    private static let key = "Wallet"
    
    static func getBalance() -> Int {
        let balance = UserDefaults.standard.integer(forKey: key)
        return balance
    }
    
    static func getReward(reward: Int) {
        let balance = getBalance() + reward
        UserDefaults.standard.set(balance, forKey: key)
    }
    
    static func exchange(cost: Int) {
        let balance = getBalance() - cost
        UserDefaults.standard.set(balance, forKey: key)
    }
}
