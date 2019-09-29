//
//  FavorateManager.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/29.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    let userDefault = UserDefaults.standard
    
    let sessionKey = "sessionKey"
    
    let unconfKey = "unconfKey"
    
    private var sessionIds: [Int] = [] {
        
        didSet {
        
            print("sessionIds", sessionIds)
        }
    }
    
    private var unconfIds: [Int] = [] {
        
        didSet {
        
            print("unconfIds", unconfIds)
        }
    }
    
    private init() {
        
        sessionIds = userDefault.array(forKey: sessionKey) as? [Int] ?? []
        
        unconfIds = userDefault.array(forKey: unconfKey) as? [Int] ?? []
        
        print("sessionIds", sessionIds)
        
        print("unconfIds", unconfIds)
    }
    
    //Public Method
    func addSessionId(id: Int) {
        
        guard sessionIds.contains(id) == false else { return }
        
        sessionIds.append(id)
        
        userDefault.setValue(sessionIds, forKey: sessionKey)
        
        print("sessionIds add", id)
        print("------------------")
    }
    
    func removeSessionId(id: Int) {
        
        guard let index = sessionIds.firstIndex(of: id) else { return }
        
        sessionIds.remove(at: index)
    
        userDefault.setValue(sessionIds, forKey: sessionKey)
    
        print("sessionIds remove", id)
        print("------------------")
    }
    
    func addUnconfId(id: Int) {
        
        guard unconfIds.contains(id) == false else { return }
        
        unconfIds.append(id)
        
        userDefault.setValue(unconfIds, forKey: unconfKey)
        
        print("unconfIds add", id)
        print("------------------")
    }
    
    func removeUnconfId(id: Int) {
        
        guard let index = unconfIds.firstIndex(of: id) else { return }
        
        unconfIds.remove(at: index)
    
        userDefault.setValue(unconfIds, forKey: unconfKey)
    
        print("unconfIds remove", id)
        print("------------------")
    }
    
    func fetchSessionIds() -> [Int] {
        
        return sessionIds
    }
    
    func fetchUnconfIds() -> [Int] {
        
        return unconfIds
    }
}
