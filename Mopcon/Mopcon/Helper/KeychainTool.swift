//
//  KeychainTool.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/9/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct KeychainTool {
    
    static func save(_ uuid: String, for email: String) {
        
        let uuid = uuid.data(using: String.Encoding.utf8)!
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: email,
                                    kSecValueData as String: uuid]
        
        // Remove old token
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else { return print("save error") }
    }
    
    static func save(_ token: String) {
        
        let token = token.data(using: String.Encoding.utf8)!
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: "token",
                                    kSecValueData as String: token]
        
        // Remove old token
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else { return print("save error") }
    }
    
    static func retrive(for key: String) -> String? {
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: kCFBooleanTrue!]
        
        var retrivedData: AnyObject? = nil
        
        let _ = SecItemCopyMatching(query as CFDictionary, &retrivedData)
        
        guard let data = retrivedData as? Data else {return nil}

        return String(data: data, encoding: String.Encoding.utf8)
    }
}
