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
    
    private var _unconfs: [Room] = []
    
    private var _sessions: [Room] = []
    
    private let dispatchGroup = DispatchGroup()
    
    var unconfs: [Room] { return _unconfs }
    
    var sessions: [Room] { return _sessions }
    
    @objc dynamic var sessionIds: [Int] = []
    
    @objc dynamic var unconfIds: [Int] = []
    
    private override init() {
        
        sessionIds = userDefault.array(forKey: sessionKey) as? [Int] ?? []
        
        unconfIds = userDefault.array(forKey: unconfKey) as? [Int] ?? []
        
        super.init()
        
        self.fetchData()
    }
    
    private func fetchData() {
        
        for id in sessionIds {
            
            dispatchGroup.enter()
            
            fetchSession(id: id, completion: { [weak self] in
            
                self?.dispatchGroup.leave()
            })
        }
        
        for id in unconfIds {
            
            dispatchGroup.enter()
            
            fetchUnconf(id: id, completion: { [weak self] in
            
                self?.dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main, execute: { [weak self] in
            
            self?.willChangeValue(for: \FavoriteManager.sessionIds)
            self?.willChangeValue(for: \FavoriteManager.unconfIds)
            
            self?.didChangeValue(for: \FavoriteManager.sessionIds)
            self?.didChangeValue(for: \FavoriteManager.unconfIds)
        })
    }
    
    //Public Method - id
    func addSessionId(id: Int) {
        
        guard sessionIds.contains(id) == false else { return }
        
        sessionIds.append(id)
        
        userDefault.setValue(sessionIds, forKey: sessionKey)
        
        fetchSession(id: id, completion: { [weak self] in
            
            self?.willChangeValue(for: \.sessionIds)
            self?.didChangeValue(for: \.sessionIds)
        })
    }
    
    func removeSessionId(id: Int) {
        
        guard let index = sessionIds.firstIndex(of: id) else { return }
        
        _sessions = _sessions.compactMap({ session in
            
            if session.sessionId == id {
                return nil
            }
            
            return session
        })
        
        sessionIds.remove(at: index)
    
        userDefault.setValue(sessionIds, forKey: sessionKey)
    }
    
    func addUnconfId(id: Int) {
        
        guard unconfIds.contains(id) == false else { return }
        
        unconfIds.append(id)
        
        userDefault.setValue(unconfIds, forKey: unconfKey)
        
        fetchUnconf(id: id, completion: { [weak self] in
            
            self?.willChangeValue(for: \.unconfIds)
            self?.didChangeValue(for: \.unconfIds)
        })
    }
    
    func removeUnconfId(id: Int) {
        
        guard let index = unconfIds.firstIndex(of: id) else { return }
        
        _unconfs = _unconfs.compactMap({ info in
            
            if info.sessionId == id {
                return nil
            }
            
            return info
        })
        
        unconfIds.remove(at: index)
    
        userDefault.setValue(unconfIds, forKey: unconfKey)
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
                    
                    self?._sessions.append(room)
                    
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
                    
                    self?._unconfs.append(sessionInfo)
                    
                    completion()
                }
                
            case .failure(let error):
                
                print(error)
                
                completion()
            }
        })
    }
}
