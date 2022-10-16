//
//  FieldGameProvider.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/9/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation
import FirebaseDynamicLinks

class FieldGameProvider: MainThreadHelper {
    
    static func register(with uid: String, and email: String, completion: (()->Void)? = nil) {
        
        HTTPClient.shared.request(
            FieldGameAPI.register(uid, email),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<Auth>.self,
                            from: data
                        )
                        
                        let token = "\(successResponse.data.tokenType) \(successResponse.data.accessToken)"
                        
                        KeychainTool.save(token)
                        
                        completion?()
                        
                    } catch {
                        
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
        })
    }
    
    static func invite(with uid: String, and email: String) {
        
        HTTPClient.shared.request(
            FieldGameAPI.invite(uid, email),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<Auth>.self,
                            from: data
                        )
                        
                        let token = "\(successResponse.data.tokenType) \(successResponse.data.accessToken)"
                
                        KeychainTool.save(token)
                        
                        KeychainTool.save(uid, for: email)
                    
                    } catch {
                        
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
        })
    }
    
    static func login(with uid: String, and password: String) {
        
        HTTPClient.shared.request(
            FieldGameAPI.login(uid, password),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<Auth>.self,
                            from: data
                        )
                        
                        let token = "\(successResponse.data.tokenType) \(successResponse.data.accessToken)"
                        
                        KeychainTool.save(token)
                        
                    } catch {
                        
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
        })
    }
    
    static func verify(with type: FieldGameAPI.VerifyType, and id: String, and vKey: String, completion: @escaping FieldGameTaskVerifiedResultType) {
        
        HTTPClient.shared.request(
            FieldGameAPI.verify(type, id, vKey),
            completion: { result in

                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<[String]>.self,
                            from: data
                        )
                        
                        throwToMainThreadAsync {
                            completion(Result.success(successResponse.message))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):

                    throwToMainThreadAsync {
                        completion(Result.failure(error))
                    }
                    
                }
        })
    }
    
    static func fetchIntro(completion: @escaping FieldGameIntroResultType) {
        
        HTTPClient.shared.request(
            FieldGameAPI.intro,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<FieldGameIntro>.self,
                            from: data
                        )
                        
                        throwToMainThreadAsync {
                            completion(Result.success(successResponse.data))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    static func fetchGameStatus(completion: @escaping FieldGameStatusResultType) {
        
        HTTPClient.shared.request(
            FieldGameAPI.me,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<FieldGameMe>.self,
                            from: data
                        )
                        
                        throwToMainThreadAsync {
                            completion(Result.success(successResponse.data))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    static func fetchTask(wtih id: String, completion: @escaping FieldGameTaskResultType) {
        
        HTTPClient.shared.request(
            FieldGameAPI.task(id),
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<FieldGameTask>.self,
                            from: data
                        )
                        
                        throwToMainThreadAsync {
                            completion(Result.success(successResponse.data))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    static func notifyReward(completion: @escaping FieldGameRewardResultType) {
        
        HTTPClient.shared.request(
            FieldGameAPI.reward,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let successResponse = try JSONDecoder.shared.decode(
                            SuccessResponse<FieldGameReward>.self,
                            from: data
                        )
                        
                        throwToMainThreadAsync {
                            completion(Result.success(successResponse.data))
                        }
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
        })
    }
    
    static var baseURL: String {
        return UserDefaults.standard.string(forKey: MPConstant.gameServerKey) ?? "https://game.mopcon.org"
    }
}
