//
//  MissionDetailViewController.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/3.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class MissionDetailViewController: UIViewController {
    
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
            let submitCell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath)
            return submitCell
        default:
            fatalError("Can't created cell.")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswer = options[indexPath.row]
        tableView.reloadData()
    }

}
