//
//  DesCoder.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/10/22.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation

class desCoder {
    
    private static let randomStringArray = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".map({$0})
    static var key:String = ""
    
    class func randomStringOfLength(_ length:Int) -> String {
        var string = ""
        for _ in (1...length) {
            string.append(randomStringArray[Int(arc4random_uniform(
                UInt32(randomStringArray.count) - 1))])
        }
        return string
    }
    
    class func encrypt(encryptData:String){
        key = randomStringOfLength(kCCKeySize3DES)
        let inputData : Data = encryptData.data(using: String.Encoding.utf8)!
        
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySize3DES)
        
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
        
        let cryptStatus = CCCrypt(
            UInt32(kCCEncrypt),
            UInt32(kCCAlgorithm3DES),
            UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding),
            keyBytes,
            keyLength,
            nil,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytesDecrypted)
        
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            bufferData.length = bytesDecrypted
            decrypt(inputData: bufferData as Data)
        } else {
            print("加密过程出错: \(cryptStatus)")
        }
    }
    
    class func decrypt(inputData : Data){
        let keyData: Data = key.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let keyBytes = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes)
        let keyLength = size_t(kCCKeySize3DES)
        let dataLength = Int(inputData.count)
        let dataBytes = UnsafeRawPointer((inputData as NSData).bytes)
        let bufferData = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
        let bufferPointer = UnsafeMutableRawPointer(bufferData.mutableBytes)
        let bufferLength = size_t(bufferData.length)
        var bytesDecrypted = Int(0)
        
        let cryptStatus = CCCrypt(
            UInt32(kCCDecrypt),
            UInt32(kCCAlgorithm3DES),
            UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding),
            keyBytes,
            keyLength,
            nil,
            dataBytes,
            dataLength,
            bufferPointer,
            bufferLength,
            &bytesDecrypted)
        
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            bufferData.length = bytesDecrypted
            let clearDataAsString = NSString(data: bufferData as Data, encoding: String.Encoding.utf8.rawValue)
            print("解密后的内容：\(clearDataAsString! as String)")
        } else {
            print("解密过程出错: \(cryptStatus)")
        }
    }
    
}
