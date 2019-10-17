//
//  FavorateManager.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/29.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class FavoriteManager: NSObject, MainThreadHelper {
    
    static let shared = FavoriteManager()
    
    private let userDefault = UserDefaults.standard
    
    private let sessionKey = "sessionKey"
    
    private let unconfKey = "unconfKey"
    
    var unconfs: [Room] = []
    
    var sessions: [Room] = []
    
    @objc dynamic var sessionIds: [Int] = [] {
        
        didSet {
            userDefault.setValue(sessionIds, forKey: sessionKey)
        }
    }
    
    @objc dynamic var unconfIds: [Int] = [] {
        
        didSet {
            userDefault.setValue(unconfIds, forKey: unconfKey)
        }
    }
    
    private override init() {
        
        sessionIds = userDefault.array(forKey: sessionKey) as? [Int] ?? []
        
        unconfIds = userDefault.array(forKey: unconfKey) as? [Int] ?? []
        
        super.init()
        
        self.fetchData()
    }
    
    private func fetchData() {
        
        for id in sessionIds {
            
            fetchSession(id: id)
        }
        
        for id in unconfIds {
            
            fetchUnconf(id: id)
        }
    }
    
    //Public Method - id
    func addSession(room: Room) {
        
        guard sessions.filter({ $0.sessionId == room.sessionId }).count == 0 else { return }
        
        sessions.append(room)
        
        sessionIds = sessions.map({ $0.sessionId })
    }
    
    func removeSession(room: Room) {
        
        sessions.removeAll(where: { $0.sessionId == room.sessionId })
        
        sessionIds = sessions.map({ $0.sessionId })
    }
    
    func removeSession(id: Int) {
        
        sessions.removeAll(where: { $0.sessionId == id })
        
        sessionIds = sessions.map({ $0.sessionId })
    }
    
    func addUnconf(room: Room) {
        
        guard unconfs.filter({ $0.sessionId == room.sessionId }).count == 0 else { return }
        
        unconfs.append(room)
        
        unconfIds = unconfs.map({ $0.sessionId })
    }
    
    func removeUnconf(room: Room) {
        
        unconfs.removeAll(where: { $0.sessionId == room.sessionId })
        
        unconfIds = unconfs.map({ $0.sessionId })
    }
    
    func removeUnconf(id: Int) {
        
        unconfs.removeAll(where: { $0.sessionId == id })
        
        unconfIds = unconfs.map({ $0.sessionId })
    }
    
    func fetchSessionIds() -> [Int] {
        
        return sessionIds
    }
    
    func fetchUnconfIds() -> [Int] {
        
        return unconfIds
    }
    
    //MARK: - Private Method
    private func fetchSession(id: Int, completion: @escaping () -> Void = {}) {
        
        SessionProvider.fetchSession(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let room):
                
                self?.throwToMainThreadAsync {
                    
                    self?.sessions.append(room)
                    
                    completion()
                }
                
            case .failure(let error):
                
                print(error)
                
                completion()
            }
        })
    }
    
    private func fetchUnconf(id: Int, completion: @escaping () -> Void = {}) {
        
        UnconfProvider.fetchUnConfInfo(id: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let sessionInfo):
                
                self?.throwToMainThreadAsync {
                    
                    self?.unconfs.append(sessionInfo)
                    
                    completion()
                }
                
            case .failure(let error):
                
                print(error)
                
                completion()
            }
        })
    }
}
