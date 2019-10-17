//
//  StageViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/30.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class StageViewController: MPBaseViewController, NoticeViewPresentable {
    
    var isLast: Bool = false
    
    var isPassed: Bool = false
    
    var missionID: String?
        
    private var taskID: String?
    
    private let spinner = LoadingTool.setActivityindicator()
    
    //MARK: - HintViewPresentable
    internal lazy var noticeView: NoticeView = {
        
        let tempNoticeView = NoticeView(frame: CGRect.zero)
        
        tempNoticeView.delegate = self
        
        return tempNoticeView
    }()
    
    internal lazy var targetFrame: CGRect = {
        
        let targetWidth = UIScreen.main.bounds.size.width - 40
        
        let targetHeight = UIScreen.main.bounds.size.height * 368 / 667
        
        return CGRect(
            x: UIScreen.main.bounds.size.width / 2 - 0.5 * targetWidth,
            y: UIScreen.main.bounds.size.height / 2 - 0.5 * targetHeight,
            width: targetWidth,
            height: targetHeight
        )
    }()
    
    @IBOutlet weak var stageImageView: UIImageView!
    
    @IBOutlet weak var stageTitleLabel: UILabel!
    
    @IBOutlet weak var stageDetailLabel: UILabel!
    
    @IBOutlet weak var qrCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "關卡" : "Mission"

        qrCodeButton.layer.cornerRadius = 6
        
        qrCodeButton.layer.borderWidth = 1
        
        updateQRCodeButton(pass: isPassed)
        
        stageImageView.layer.cornerRadius = 6
        
        stageImageView.layer.borderColor = UIColor.azure?.cgColor
        
        stageImageView.layer.borderWidth = 1
        
        stageImageView.contentMode = .scaleAspectFill
        
        startSpinner()
        
        if let missionID = self.missionID {
           
            fetchTask(with: missionID)
        } else {
            
            stopSpinner()
        }
    }
    
    private func updateQRCodeButton(pass: Bool) {
        
        var title = ""
        
        if pass {
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "任務已完成" : "Completed"
            
        } else {
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "掃描 QR Code" : "Scan QR Code"
        }
        
        let titleColor = pass ? UIColor.brownGray : UIColor.white
        
        qrCodeButton.backgroundColor = pass ? UIColor.clear : UIColor.azure
        
        qrCodeButton.setTitleColor(titleColor, for: .normal)
        
        qrCodeButton.setTitle(title, for: .normal)
        
        qrCodeButton.layer.borderColor = pass ? UIColor.brownGray?.cgColor : UIColor.azure?.cgColor
        
        qrCodeButton.isEnabled = !pass
    }
    
    private func startSpinner() {
        
        spinner.startAnimating()
        
        spinner.center = view.center
        
        view.addSubview(spinner)
    }
    
    private func stopSpinner() {
        
        spinner.removeFromSuperview()
    }
    
    private func fetchTask(with id: String) {
        
        FieldGameProvider.fetchTask(wtih: id, completion: { [weak self] result in
            
            switch result {
                
            case .success(let task):
                
                self?.stopSpinner()
                
                self?.stageTitleLabel.text = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? task.name : task.nameEn
                
                self?.stageDetailLabel.text = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? task.description : task.descriptionEn
                
                self?.stageImageView.loadImage(task.image)
                
                self?.taskID = task.uid
                
            case .failure(let error):
                
                print(error)
            }
        })
        
    }
    
    @IBAction func openQRCodeScanner() {
        
        let qrCodeViewController = QRCodeViewController()
        
        qrCodeViewController.taskID = taskID
        
        qrCodeViewController.getInteractionMissionResult = self
                
        let navigationController = UINavigationController(rootViewController: qrCodeViewController)
                
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true, completion: nil)
    }
    
}

extension StageViewController: GetInteractionMissionResult {
    
    func updateMissionStatus() {
        
        noticeView.updateUI(with: .finish, and: nil)
        
        presentHintView()
        
        updateQRCodeButton(pass: true)
        
        if let parentViewController = navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as? FieldGameViewController {
        
            parentViewController.fetchGameStatus()
            
            if isLast {
                
                let keyReward = "hasOpenedReward"
                
                UserDefaults.standard.set(true, forKey: keyReward)
            }
        }
    }
}

extension StageViewController: NoticeViewDelegate {
    
    func didTouchOKButton(_ noticeView: NoticeView, type: NoticeType) {}
}
