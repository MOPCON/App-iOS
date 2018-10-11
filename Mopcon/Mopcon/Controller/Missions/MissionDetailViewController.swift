//
//  MissionDetailViewController.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/3.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

enum SolvesStatus {
    case noAnswer
    case success
    case fail
}

class MissionDetailViewController: UIViewController {
    
    var mission: Quiz.Item?
    var missionStatus = SolvesStatus.noAnswer
    var selectedAnswer: String?
    var options = [String]()
    var reward: Int?
    var answer: String {
        
        if let string = mission?.answer, let option = mission?.options  {
            if let index = Int(string) {
                return option[index - 1]
            }
        }
        
        return "?"
    }
    
    @IBOutlet weak var missionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionTableView.dataSource = self
        missionTableView.delegate = self
        
        if let item = mission, let options = item.options {
            self.options = options
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Tableview datasource & delegate
extension MissionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return options.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let questionCell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
            guard let questionLabel = questionCell.viewWithTag(1) as? UILabel else {  fatalError("Can't find questionLabel")}
            questionLabel.text = mission?.title
            return questionCell
        case 1:
            let answerCell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
            let startingValue = Int(("A" as UnicodeScalar).value)
            
            guard let iconLabel = answerCell.viewWithTag(11) as? UILabel else {  fatalError("Can't find iconLabel")}
            guard let optionLabel = answerCell.viewWithTag(12) as? UILabel else {  fatalError("Can't find optionLabel")}
            
            iconLabel.text = "\(Character(UnicodeScalar(indexPath.row + startingValue)!))"
            iconLabel.layer.cornerRadius = 11
            iconLabel.clipsToBounds = true
            iconLabel.layer.borderColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
            iconLabel.layer.borderWidth = 1
            optionLabel.text = options[indexPath.row]
            
            switch missionStatus {
            case .noAnswer:
                if optionLabel.text == selectedAnswer {
                    iconLabel.textColor = .white
                    iconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                } else {
                    iconLabel.backgroundColor = .clear
                    iconLabel.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                }
            case .fail:
                if optionLabel.text == selectedAnswer {
                    iconLabel.textColor = .white
                    iconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                } else if optionLabel.text == answer {
                    iconLabel.backgroundColor = .red
                    iconLabel.layer.borderColor = UIColor.red.cgColor
                    iconLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                
                
            case .success:
                break
            }
            
            return answerCell
        case 2:
            
            switch missionStatus {
            case .noAnswer:
                let submitCell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath)
                
                if let sumbitButton = submitCell.viewWithTag(31) as? UIButton {
                    sumbitButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
                }
                
                return submitCell
            case .success:
                let successCell = tableView.dequeueReusableCell(withIdentifier: "successCell", for: indexPath)
                if let rewardLabel = successCell.viewWithTag(41) as? UILabel, let reward = reward {
                    rewardLabel.text = "\(reward)"
                }
                return successCell
            case .fail:
                let failCell = tableView.dequeueReusableCell(withIdentifier: "failCell", for: indexPath)
                return failCell
            }
            
        default:
            fatalError("Can't created cell.")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            if missionStatus == .success {
                return 190
            } else {
                return 150
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && missionStatus == .noAnswer {
            selectedAnswer = options[indexPath.row]
            tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
    }
    
    @objc func checkAnswer() {
        
        let body: [String: Any ] = [
            "public_key": "123-456",
            "id" : 3,
            "answer" : 4
        ]
        
        FieldGameAPI.solveQuiz(jsonData: body) { (data) in
            
            if self.selectedAnswer == self.answer {
                self.missionStatus = .success
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(Result.self, from: data), let reward = json.reward {
                    self.reward = reward
                }
            } else {
                self.missionStatus = .fail
            }
            
            DispatchQueue.main.async {
                self.missionTableView.reloadData()
            }
        }
    }
    
}
