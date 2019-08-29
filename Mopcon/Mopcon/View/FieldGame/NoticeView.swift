//
//  NoticeView.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/8/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol NoticeViewPresentable {
    
    var noticeView: NoticeView { get }
    
    var targetFrame: CGRect { get }
}

extension NoticeViewPresentable {
    
    func presentHintView() {
        
        noticeView.frame = UIScreen.main.bounds
        
        noticeView.contentView.frame = targetFrame
        
        (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(noticeView)
    }
}

enum NoticeType {
    case welcome
    case reward
    case exchange
    case finish
}

class NoticeView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var noticeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed(NoticeView.identifier, owner: self, options: nil)
        
        addSubview(contentView)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        cancelButton.layer.borderColor = UIColor.azure?.cgColor
    }
    
    func updateUI(with type: NoticeType) {
        
        var title = ""
        
        var description = ""
        
        var image = UIImage()
        
        switch type {
            
        case .welcome:
            
            image = #imageLiteral(resourceName: "welcome")
            
            title = (CurrentLanguage.getLanguage() == "Chinese") ? "歡迎加入" : "Welcome"
            
            description = (CurrentLanguage.getLanguage() == "Chinese") ? "歡迎來到Mopcon闖關大進擊，透過達成各關卡任務，將有神秘大獎等著你!" : ""

        case .reward:

            image = #imageLiteral(resourceName: "reward")
            
            title = (CurrentLanguage.getLanguage() == "Chinese") ? "獲得獎勵" : "Reward"
            
            description = (CurrentLanguage.getLanguage() == "Chinese") ? "恭喜獲得！\n 您可在我的獎勵中查詢兌換說明" : ""
            
        case .exchange:
            
            image = #imageLiteral(resourceName: "exchange")
            
            title = (CurrentLanguage.getLanguage() == "Chinese") ? "輸入兌換密碼" : "Enter Password"
            
        case .finish:
            
            image = #imageLiteral(resourceName: "finish")
            
            title = (CurrentLanguage.getLanguage() == "Chinese") ? "任務成功" : "Finish"
            
            description = (CurrentLanguage.getLanguage() == "Chinese") ? "恭喜你完成此任務，讓 Mopcon 更加成長茁壯一大步！" : ""
        }
        
        
        titleLabel.text = title
        
        descriptionLabel.text = description
        
        noticeImageView.image = image
        
        if type == .exchange {
            
            cancelButton.isHidden = false
            
            descriptionLabel.isHidden = true
            
            passwordTextField.isHidden = false
        
        } else {
            
            cancelButton.isHidden = true
            
            descriptionLabel.isHidden = false
        
            passwordTextField.isHidden = true
        }
        
    }
    
    private func presentAnimation() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            
            self?.center = CGPoint(x: (width / 2), y: (height / 2))
        })
    }
    
    private func dismissAnimation() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            
            self?.contentView.frame.origin.y = UIScreen.main.bounds.height
            
        }, completion: { [weak self] _ in
            
            self?.removeFromSuperview()
        })
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        
        print(123)
        dismissAnimation()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        print(456)
        dismissAnimation()
    }
    
    
}
