//
//  FieldGameAPI.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/9/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

enum FieldGameAPI: LKRequest {
    
    case register(String, String)
    
    case invite(String, String)
    
    case login(String, String)
    
    case intro
    
    case me
    
    case task(String)
    
    case reward
    
    case verify(VerifyType, String, String)
    
    case mySession(id: Int, action:String)
    
    var endPoint: String {
        
        switch self {
            
        case .register: return "/register"
            
        case .invite: return "/invite"
            
        case .login: return "/login"
            
        case .me: return "/me"
            
        case .intro: return "/intro"
    
        case .task(let missionId): return "/getTask/\(missionId)"
            
        case .reward: return "/getReward"
            
        case .verify(let vType, _, _): return "/verify/\(vType.rawValue)"
            
        case .mySession: return "/mySession"
        }
    }
    
    enum VerifyType: String {
        
        case task = "task"
        
        case reward = "reward"
    }
    
    var method: String {
        
        switch self {
            
        case .register, .invite, .login, .verify, .mySession: return LKHTTPMethod.post.rawValue
            
        default: return LKHTTPMethod.get.rawValue
        }
    }
    
    var baseURL: String {

        //MARK: should refactor
        return UserDefaults.standard.string(forKey: MPConstant.gameServerKey) ?? "https://game.mopcon.org"
        
//        return "https://game-test.mopcon.org"
    }
    
    var headers: [String : String] {
        
        switch self {
        
        case .register, .invite, .login:
            
            return [LKHTTPHeaderField.contentType.rawValue: LKHTTPHeaderValue.json.rawValue]
            
        case .verify:
            
            let token = KeychainTool.retrive(for: "token")
            
            return [LKHTTPHeaderField.contentType.rawValue: LKHTTPHeaderValue.json.rawValue,
                    LKHTTPHeaderField.auth.rawValue: token!]
            
        case .intro:
            
            return [:]
            
        default:
            
            let token = KeychainTool.retrive(for: "token")
            
            return [LKHTTPHeaderField.auth.rawValue: token!]
        }
    }
    
    var body: Data? {
        
        switch self {
        
        case .register(let uid, let email), .invite(let uid, let email): return makeBody(with: ["uid": uid, "email": email])
            
        case .login(let uid, let password): return makeBody(with: ["uid": uid, "password": password])
            
        case .verify(_, let uid, let vKey): return makeBody(with: ["uid": uid, "vKey": vKey])
            
        case .mySession(let id, let action):
            
            return makeBody(with: ["session_id": id, "action": action])

        default: return nil
        }
    }
    
    private func makeBody(with parameters: [String: Any]) -> Data? {

        do{
            
            let body = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
            
            return body
            
        } catch {
            
            print(error.localizedDescription)
            
            return nil
        }
    }
}


