//
//  FieldGameAPI.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/26.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class FieldGameOldAPI {
    
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
    
    // POST
    class func newUserRequest(parameters: [String: Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.new_user)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
             request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func getBalanceRequest(parameters: [String: Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.get_balance)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
   
    class func buyGachapon(parameters: [String: Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.buy_gachapon)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func solveQuiz(parameters: [String: Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.solve_quiz)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func getHawkerQRCode(json: [String:Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.get_hawker_qrcode)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
    class func getHawkerMission(json: [String:Any], completion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: MopconAPI.shared.get_hawker_mission)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
        
        fetchDataByDataTask(from: request, completion: completion)
    }
    
}
