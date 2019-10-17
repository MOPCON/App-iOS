//
//  KeychainTool.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/9/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

struct KeychainTool {
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    static func save(_ uuid: String, for email: String) {
        
        // Save uuid
        let uuid = uuid.data(using: String.Encoding.utf8)!
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: "uuid",
                                    kSecValueData as String: uuid]
        
        // Remove old uuid
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else { return print("save uuid error") }
        
        // Save email
        let email = email.data(using: String.Encoding.utf8)!
        
        let query2: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: "email",
                                     kSecValueData as String: email]
        
        // Remove old email
        SecItemDelete(query2 as CFDictionary)

        let status2 = SecItemAdd(query2 as CFDictionary, nil)

        guard status2 == errSecSuccess else { return print("save email error") }

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
