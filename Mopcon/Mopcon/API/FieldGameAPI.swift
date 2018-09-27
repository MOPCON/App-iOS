//
//  FieldGameAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/26.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class FieldGameAPI {
    
    // URLSession
    private class func fetchDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            completion(data)
            }.resume()
    }
    
    // URLRequest
    
    // GET
    
    class func getQuiz(completion: @escaping (Data) -> Void) {
        let url = MopconAPI.shared.get_quiz
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            completion(data)
            }.resume()
    }
    
    // POST
    class func newUserRequest(user: User, completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.new_user)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEncoder = JSONEncoder()
            let encoded = try jsonEncoder.encode(user)
            request.httpBody = encoded
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func getBalanceRequest(user: User, completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.get_balance)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEncoder = JSONEncoder()
            let encoded = try jsonEncoder.encode(user)
            request.httpBody = encoded
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
   
    class func buyGachapon(user: User, completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.buy_gachapon)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEncoder = JSONEncoder()
            let encoded = try jsonEncoder.encode(user)
            request.httpBody = encoded
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func solveQuiz(jsonData: [String:Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.solve_quiz)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func getHawkerQRCode(jsonData: [String:Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.get_hawker_qrcode)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func getHawkerMission(jsonData: [String:Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.get_hawker_mission)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
}
