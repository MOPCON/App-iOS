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
    
    func showMissionInfo() {
        
        backView = UIView()
        backView.frame = UIScreen.main.bounds
        backView.backgroundColor = .black
        backView.alpha = 0.7
        self.view.addSubview(backView)
        
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
        startButton.addTarget(self, action: #selector(startMissions(sender:)), for: UIControlEvents.touchUpInside)
        
        infoView.addSubview(titleLabel)
        infoView.addSubview(contentLabel)
        infoView.addSubview(startButton)
    }
    
    @objc func startMissions(sender:UIButton) {
        if let infoView = sender.superview {
            backView.removeFromSuperview()
            infoView.removeFromSuperview()
        }
    }

}

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
            
            return coinCell
        case 1:
            let missionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "missionCell", for: indexPath)
            missionCell.layer.cornerRadius = 6
            missionCell.layer.borderWidth = 1
            missionCell.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.9764705882, alpha: 1).cgColor
            missionCell.clipsToBounds = true
            
            guard let lockImageView = missionCell.viewWithTag(11) as? UIImageView else { fatalError("Can't find lockImageView.")}
            guard let missionTypeLabel = missionCell.viewWithTag(12) as? UILabel else { fatalError("Can't find missionTypeLabel.")}
            guard let missionTitleLabel = missionCell.viewWithTag(13) as? UILabel else { fatalError("Can't find missionTitleLabel.")}
            
            missionTypeLabel.text = missions[indexPath.row][0]
            missionTitleLabel.text = missions[indexPath.row][1]
            
            if missionTypeLabel.text != "解鎖倒數" {
                lockImageView.isHidden = true
            }
            
            return missionCell
        default:
            fatalError("Couldn't create cell.")
        }
    }
}

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
        
        let missionCell = collectionView.cellForItem(at: indexPath)
        
        guard let missionTypeLabel = missionCell?.viewWithTag(12) as? UILabel else { fatalError("Can't find missionTypeLabel") }
        
        switch missionTypeLabel.text {
        case "Q&A":
            self.performSegue(withIdentifier: "performMissionDetail", sender: nil)
        case "INTERACTION":
            self.performSegue(withIdentifier: "performInteractionDetail", sender: nil)
        default:
            break
        }
        
    }
}
