//
//  File.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/25.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct Quiz: Codable {
    var id: String
    var type: String
    var title: String
    var description: String
    var options: [String: String]
    var banner_url: String
    var status: String
    var reward: Int
    var answer: String
    var myAnswer: String?
    
    static let key = "Quiz"
    
    static func getData() -> [Quiz] {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            let quiz = try! decoder.decode([Quiz].self, from: savedData)
            saveData(array: quiz)
            return quiz
        }
        let url = Bundle.main.url(forResource: "Quiz", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        var quiz = try! decoder.decode([Quiz].self, from: data)
        for i in quiz.indices {
            if quiz[i].status == "-1" {
                quiz[i].status = QuizStatus.unlock.rawValue
            }
            print(quiz[i].title,quiz[i].status)
        }
        saveData(array: quiz)
        return quiz
    }
    
    static func saveData(array: [Quiz]) {
        let encoder = JSONEncoder()
        let saveData = try! encoder.encode(array)
        UserDefaults.standard.set(saveData, forKey: key)
    }
    
    static func solveQuiz(id: String, answer: String, status: String) {
        var quiz = getData()
        for i in quiz.indices {
            if quiz[i].id == id {
                quiz[i].status = status
                quiz[i].myAnswer = answer
            }
        }
        saveData(array: quiz)
    }
}
