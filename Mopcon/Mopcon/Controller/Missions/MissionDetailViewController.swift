//
//  MissionDetailViewController.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/3.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class MissionDetailViewController: UIViewController {
    
    var mission: Quiz?
    var selectedAnswer: String?
    var reward: Int?
    
    @IBOutlet weak var missionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionTableView.dataSource = self
        missionTableView.delegate = self
        
        if let myAnswer = mission?.myAnswer {
            selectedAnswer = myAnswer
            missionTableView.reloadData()
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
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let status = mission?.status else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let questionCell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
            guard let questionLabel = questionCell.viewWithTag(1) as? UILabel else {  return UITableViewCell() }
            questionLabel.text = mission?.title
            return questionCell
        case 1:
            let answerCell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
            let startingValue = Int(("A" as UnicodeScalar).value)
            
            guard let iconLabel = answerCell.viewWithTag(11) as? UILabel else {  return UITableViewCell() }
            guard let optionLabel = answerCell.viewWithTag(12) as? UILabel else {  return UITableViewCell() }
            
            iconLabel.text = "\(Character(UnicodeScalar(indexPath.row + startingValue)!))"
            iconLabel.layer.cornerRadius = 11
            iconLabel.clipsToBounds = true
            iconLabel.layer.borderColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
            iconLabel.layer.borderWidth = 1
            optionLabel.text = mission?.options?["\(indexPath.row + 1)"]
            let row = "\(indexPath.row + 1)"
            switch status {
            case QuizStatus.unlock.rawValue:
                if row == selectedAnswer {
                    iconLabel.textColor = .white
                    iconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                } else {
                    iconLabel.backgroundColor = .clear
                    iconLabel.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                }
            case QuizStatus.fail.rawValue:
                if row == selectedAnswer {
                    iconLabel.textColor = .white
                    iconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                } else if row == mission?.answer {
                    iconLabel.backgroundColor = .red
                    iconLabel.layer.borderColor = UIColor.red.cgColor
                    iconLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            case QuizStatus.success.rawValue:
                if row == selectedAnswer {
                    iconLabel.textColor = .white
                    iconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
                }
            default:
                break
            }
            
            return answerCell
        case 2:
            switch status {
            case QuizStatus.unlock.rawValue:
                let submitCell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath)
                
                if let sumbitButton = submitCell.viewWithTag(31) as? UIButton {
                    sumbitButton.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
                }
                
                return submitCell
            case QuizStatus.success.rawValue:
                let successCell = tableView.dequeueReusableCell(withIdentifier: "successCell", for: indexPath)
                if let rewardLabel = successCell.viewWithTag(41) as? UILabel, let reward = reward {
                    rewardLabel.text = "\(reward)"
                }
                return successCell
            case QuizStatus.fail.rawValue:
                let failCell = tableView.dequeueReusableCell(withIdentifier: "failCell", for: indexPath)
                return failCell
            default:
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let status = mission?.status else { return UITableView.automaticDimension }
        if indexPath.section == 2 {
            if status == QuizStatus.success.rawValue {
                return 190
            } else {
                return 150
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let status = mission?.status else { return  }
        if indexPath.section == 1 && status == QuizStatus.unlock.rawValue {
            selectedAnswer = "\(indexPath.row + 1)"
            tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
    }
    
    @objc func checkAnswer() {
        if let myAnswer = selectedAnswer, let mission = mission {
            if myAnswer == mission.answer {
                self.reward = NSString(string: mission.reward).integerValue
                self.mission?.status = QuizStatus.success.rawValue
                Quiz.solveQuiz(id: mission.id, answer: myAnswer, status: QuizStatus.success.rawValue)
                Wallet.getReward(reward: NSString(string: mission.reward).integerValue)
            } else {
                self.mission?.status = QuizStatus.fail.rawValue
                Quiz.solveQuiz(id: mission.id, answer: myAnswer, status: QuizStatus.fail.rawValue)
            }
        }
        self.missionTableView.reloadData()
    }
    
}
