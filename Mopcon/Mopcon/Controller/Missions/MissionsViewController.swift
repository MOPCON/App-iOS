//
//  MissionsViewController.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/3.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class MissionsViewController: UIViewController {
    
    var backView: UIView!
    
    var missions:[[String]] = [
        ["Q&A","區塊鏈為何..."],
        ["INTERACTION","找到紫色小鴨"],
        ["解鎖倒數","01:22:03"],
        ["Q&A","領域分析"],
        ["Q&A","UX 入門考驗"],
        ["INTERACTION","找到黑色小雞"]
    ]

    @IBOutlet weak var missionsCollectionView: UICollectionView!
    
    @IBAction func exit(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting clear navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        missionsCollectionView.dataSource = self
        missionsCollectionView.delegate = self
        
        showMissionInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Show customized alert
    
    func addBackView() {
        backView = UIView()
        backView.frame = UIScreen.main.bounds
        backView.backgroundColor = .black
        backView.alpha = 0.7
        self.view.addSubview(backView)
    }
    
    func showMissionInfo() {
        
        addBackView()
        
        let infoView = UIView()
        infoView.frame = CGRect(x: 0, y: 0, width: missionsCollectionView.bounds.width, height: missionsCollectionView.bounds.width * 0.92)
        infoView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        infoView.backgroundColor = #colorLiteral(red: 0, green: 0.007843137255, blue: 0.1921568627, alpha: 1)
        infoView.layer.cornerRadius = 4
        infoView.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
        infoView.layer.borderWidth = 2
        self.view.addSubview(infoView)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x:0, y: 0, width: infoView.bounds.width, height: infoView.bounds.width * 0.14)
        titleLabel.center = CGPoint(x: infoView.bounds.midX, y: titleLabel.bounds.height * 1.3)
        titleLabel.text = "搶攻 MO 幣"
        titleLabel.font = UIFont(name: "PingFangTC-Semibold", size: 30)
        titleLabel.textColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1)
        titleLabel.textAlignment = .center
        
        let contentLabel = UILabel()
        contentLabel.frame = CGRect(x: 0, y: 0, width: infoView.bounds.width * 0.9, height: infoView.bounds.height * 0.3)
        contentLabel.center = CGPoint(x: infoView.bounds.midX, y: infoView.bounds.midY)
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 3
        
        let text = NSMutableAttributedString(string: "透過回答問題和攤位互動收集 MO 幣，累積越多就可以兌換越多扭蛋，裡面藏有各式各樣神秘大獎等著你！")
        let range = NSRange(location: 0, length: text.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 8
        
        text.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        text.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "PingFangTC-Semibold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16), range: range)
        text.addAttribute(NSAttributedStringKey.kern, value: 1.3, range: range)
        
        contentLabel.attributedText = text
        
        let startButton = UIButton()
        startButton.frame = CGRect(x: 0, y: 0, width: infoView.bounds.width * 0.9, height: 60)
        startButton.center = CGPoint(x: infoView.bounds.midX, y:infoView.bounds.maxY - startButton.bounds.height * 0.8)
        startButton.layer.cornerRadius = 3
        startButton.clipsToBounds = true
        startButton.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1)
        startButton.tintColor = .white
        startButton.setTitle("開始任務", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "PingFangTC-Semibold", size: 20)
        startButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
        
        infoView.addSubview(titleLabel)
        infoView.addSubview(contentLabel)
        infoView.addSubview(startButton)
    }
    
    @objc func exchangeCapsule(sender:UIButton) {
        
        addBackView()
        
        let alertView = UIView()
        alertView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.9, height: view.bounds.width * 0.9 * 0.53)
        alertView.center = view.center
        alertView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2, alpha: 1)
        alertView.layer.cornerRadius = 4
        alertView.clipsToBounds = true
        alertView.layer.borderColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        alertView.layer.borderWidth = 2
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: alertView.bounds.width * 0.9, height: 40)
        textField.center = CGPoint(x: alertView.bounds.midX, y: textField.bounds.height * 1.8)
        textField.font = UIFont(name: "PingFangTC-Semibold", size: 20)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "請輸入兌換密碼",attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 0.6)])
        textField.borderStyle = .none
        
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: textField.bounds.width, height: 2)
        lineView.center = textField.center
        lineView.center.y += textField.bounds.height / 2
        lineView.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        
        let sendButton = UIButton()
        sendButton.frame = CGRect(x: 0, y: 0 , width: textField.bounds.width, height: 60)
        sendButton.center = lineView.center
        sendButton.center.y += sendButton.bounds.height
        sendButton.layer.cornerRadius = 3
        sendButton.clipsToBounds = true
        sendButton.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        sendButton.setTitle("送出", for: .normal)
        sendButton.titleLabel?.font = UIFont(name: "PingFangTC-Semibold", size: 20)
        sendButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
        
        alertView.addSubview(textField)
        alertView.addSubview(lineView)
        alertView.addSubview(sendButton)
        
        self.view.addSubview(alertView)
        
    }
    
    func showExchangeInfo() {
        
        addBackView()
        
        let alertView = UIView()
        alertView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.9, height: view.bounds.width * 0.9 * 0.83)
        alertView.center = view.center
        alertView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2, alpha: 1)
        alertView.layer.cornerRadius = 4
        alertView.clipsToBounds = true
        alertView.layer.borderColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        alertView.layer.borderWidth = 2
        
        let capsuleImageView = UIImageView()
        capsuleImageView.image = #imageLiteral(resourceName: "iconCapsule")
        capsuleImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        capsuleImageView.center = CGPoint(x: alertView.bounds.midX, y: 50 * 1.62)
        
        let messageLabel = UILabel()
        messageLabel.frame = CGRect(x: 0, y: 0, width: alertView.bounds.width * 0.91, height: 30)
        messageLabel.center = CGPoint(x: alertView.bounds.midX, y: alertView.bounds.midY)
        messageLabel.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        messageLabel.textAlignment = .center
        var text = NSMutableAttributedString()
        text = NSMutableAttributedString(string: "您即將兌換 50 個扭蛋", attributes: [NSAttributedStringKey.font:UIFont(name: "PingFangTC-Semibold", size: 24)!])
        text.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location:6,length:2))
        text.addAttribute(NSAttributedStringKey.kern, value: 0.8, range: NSRange(location: 0, length: text.length))
        messageLabel.attributedText = text
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 0, y: 0, width: alertView.bounds.width * 0.43, height: 60)
        cancelButton.center = CGPoint(x: cancelButton.bounds.width * 0.61, y: alertView.bounds.height - cancelButton.bounds.height * 0.77)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.titleLabel?.textColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        cancelButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2, alpha: 1)
        cancelButton.layer.cornerRadius = 4
        cancelButton.clipsToBounds = true
        cancelButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        cancelButton.layer.borderWidth = 2
        cancelButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
        
        let confirmButton = UIButton()
        confirmButton.frame = cancelButton.frame
        confirmButton.center.x += 17 + cancelButton.bounds.width
        confirmButton.setTitle("確認", for: .normal)
        confirmButton.titleLabel?.textColor = .white
        confirmButton.backgroundColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        confirmButton.layer.cornerRadius = 4
        confirmButton.clipsToBounds = true
        confirmButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8156862745, blue: 0.7960784314, alpha: 1)
        confirmButton.layer.borderWidth = 2
        confirmButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
        
        alertView.addSubview(capsuleImageView)
        alertView.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(confirmButton)
        
        view.addSubview(alertView)
        
    }
    
    // Button Action
    
    @objc func closeView(sender:UIButton) {
        if let alertView = sender.superview {
            alertView.removeFromSuperview()
            backView.removeFromSuperview()
        }
        
        guard let title = sender.titleLabel?.text else { return }
        
        if title == "送出" {
            showExchangeInfo()
        }
    }

}


// MARK: - Collection datasource & delegate
extension MissionsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return missions.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let coinCell = collectionView.dequeueReusableCell(withReuseIdentifier: "coinCell", for: indexPath)
            coinCell.layer.cornerRadius = 6
            coinCell.layer.borderWidth = 1
            coinCell.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
            coinCell.clipsToBounds = true

            guard let exchangeButton = coinCell.viewWithTag(3) as? UIButton else { fatalError("Can't find exchangeButton") }
            exchangeButton.addTarget(self, action: #selector(exchangeCapsule(sender:)), for: .touchUpInside)
            
            return coinCell
        case 1:
            guard let missionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "missionCell", for: indexPath) as? MissionCollectionViewCell else { fatalError("Can't created MissionCollecitonViewCell")}
            missionCell.layer.cornerRadius = 6
            missionCell.layer.borderWidth = 1
            missionCell.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
            missionCell.clipsToBounds = true
            
            missionCell.typeLabel.text = missions[indexPath.row][0]
            missionCell.titleLabel.text = missions[indexPath.row][1]

            if missionCell.typeLabel.text == "解鎖倒數" {
                missionCell.lockImageView.isHidden = false
            } else {
                missionCell.lockImageView.isHidden = true
            }
            
            if indexPath.row == 3 {
                missionCell.missionCompleted(isSuccess: false)
            }
            
            if indexPath.row == 4 {
                missionCell.missionCompleted(isSuccess: true)
            }

            return missionCell
        default:
            fatalError("Couldn't create cell.")
        }
    }
}

// MARK: - Collectionview delegate flowlayoyt
extension MissionsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: width * 193 / 336 )
        case 1:
            return CGSize(width: (width - 16) / 2 , height: (width - 16) / 2)
        default:
            return CGSize.init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets.init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let missionCell = collectionView.cellForItem(at: indexPath) as? MissionCollectionViewCell else { return }
        
        switch missionCell.typeLabel.text {
        case "Q&A":
            self.performSegue(withIdentifier: "performMissionDetail", sender: nil)
        case "INTERACTION":
            self.performSegue(withIdentifier: "performInteractionDetail", sender: nil)
        default:
            break
        }
        
    }
}
