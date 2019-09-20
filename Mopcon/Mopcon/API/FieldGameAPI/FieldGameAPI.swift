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
    
    case login(String, String)
    
    case intro
    
    case me
    
    case task(String)
    
    case reward
    
    case verify(VerifyType, String, String)
    
    var endPoint: String {
        
        switch self {
            
        case .register(_, _): return "/register"
            
        case .login(_, _): return "/login"
            
        case .me: return "/me"
            
        case .intro: return "/intro"
    
        case .task(let missionId): return "/getTask/\(missionId)"
            
        case .reward: return "/getReward"
            
        case .verify(let vType, _, _): return "/verify/\(vType.rawValue)"
        }
    }
    
    enum VerifyType: String {
        
        case task = "task"
        
        case reward = "reward"
    }
    
    var method: String {
        
        switch self {
            
        case .register, .login, .verify: return LKHTTPMethod.post.rawValue
            
        default: return LKHTTPMethod.get.rawValue
        }
    }
    
    var baseURL: String {
        
        return UserDefaults.standard.string(forKey: MPConstant.gameServerKey) ?? ""
    }
    
    var headers: [String : String] {
        
        switch self {
        
        case .register, .login:
            
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
        
        case .register(let uid, let email): return makeBody(with: ["uid": uid, "email": email])
            
        case .login(let uid, let password): return makeBody(with: ["uid": uid, "password": password])
            
        case .verify(_, let uid, let vKey): return makeBody(with: ["uid": uid, "vKey": vKey])

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


