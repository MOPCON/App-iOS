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
    
    var missionStatus = SolvesStatus.noAnswer
    var selectedAnswer = ""
    var options = [String]()
    
    @IBOutlet weak var missionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionTableView.dataSource = self
        missionTableView.delegate = self
        
        //MARK: Fake data
        options = ["區塊鏈是藉由密碼學串接並保護內容的串連交易記錄。","每一個區塊包含了前個區塊的加密","區塊內容具有難以竄改的特性。用區塊鏈所串接的分散式帳本能讓兩方有效紀錄交易，且可永久查驗此交易。"]
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
            questionLabel.text = "區塊鏈為何稱為區塊鏈？"
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
            
            if optionLabel.text == selectedAnswer {
                iconLabel.textColor = .white
                iconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
            } else {
                iconLabel.backgroundColor = .clear
                iconLabel.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
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
            tableView.reloadData()
        }
    }
    
    @objc func checkAnswer() {
        
        let answer: [String: Any ] = [
            "public_key": "123-456",
            "id" : 3,
            "answer" : 4
        ]
        
        FieldGameAPI.solveQuiz(jsonData: answer) { (data) in
            self.missionStatus = .fail
            DispatchQueue.main.async {
                self.missionTableView.reloadSections(IndexSet.init(integer: 2), with: .automatic)
            }
        }
    }
    
}
