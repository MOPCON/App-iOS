//
//  NoticeView.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/8/17.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol NoticeViewPresentable: AnyObject {
    
    var noticeView: NoticeView { get }
    
    var targetFrame: CGRect { get }
}

extension NoticeViewPresentable {
    
    func presentHintView() {
        
        noticeView.frame = UIScreen.main.bounds
        
        let initFrame = CGRect(
            x: targetFrame.origin.x,
            y: UIScreen.main.bounds.height,
            width: targetFrame.size.width,
            height: targetFrame.size.height
        )
        
        noticeView.contentView.frame = initFrame
        
        (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(noticeView)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.noticeView.contentView.frame = strongSelf.targetFrame
        })
    }
}

protocol NoticeViewDelegate: AnyObject {
    
    func didTouchOKButton(_ noticeView: NoticeView, type: NoticeType)
    
    func didTouchCancelButton(_ noticeView: NoticeView)
}

extension NoticeViewDelegate {
    
    func didTouchOKButton(_ noticeView: NoticeView?) { }
    
    func didTouchCancelButton(_ noticeView: NoticeView) { }
}

enum NoticeType {
    
    case welcome
    
    case reward
    
    case exchange
    
    case finish
    
    case allFinish
}

class NoticeView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var noticeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    private var type: NoticeType = .welcome

    weak var delegate: NoticeViewDelegate?
    
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
        
        cancelButton.layer.borderColor = UIColor.secondThemeColor?.cgColor
    }
    
    func updateUI(with type: NoticeType, and data: AnyObject? = nil) {
        
        self.type = type
        
        var title = ""
        
        var description = ""
        
        var image = UIImage()
        
        switch type {
            
        case .welcome:
            
            image = #imageLiteral(resourceName: "welcome")
            
            guard let intro = data as? FieldGameIntro else { return }
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? intro.title : intro.titleEn
            
            description = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? intro.description : intro.descriptionEn

        case .reward:
            
            guard let reward = data as? FieldGameReward else { return }

            image = #imageLiteral(resourceName: "reward")
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "獲得獎勵" : "Reward"
            
            description = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "恭喜獲得 \(reward.name)！\n 您可在我的獎勵中查詢兌換說明" : "Congratulation on getting \(reward.nameEn) !"
            
        case .exchange:
            
            image = #imageLiteral(resourceName: "exchange")
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "輸入兌換密碼" : "Enter Password"
            
        case .finish:
            
            image = #imageLiteral(resourceName: "finish")
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "任務成功" : "Finish"
            
            description = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "恭喜你完成此任務，讓 Mopcon 更加成長茁壯一大步！" : "Congratulation on completing this mission"
            
        case .allFinish:
            image = #imageLiteral(resourceName: "reward")
            
            title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "全部解開啦" : "All finished"
            
            description = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "記得去我的獎勵中對講哦" : "Congratulation on completing all the missions"
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
    
    private func dismissAnimation() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            
            self?.contentView.frame.origin.y = UIScreen.main.bounds.height
            
        }, completion: { [weak self] _ in
            
            self?.removeFromSuperview()
        })
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        
        delegate?.didTouchOKButton(self, type: type)
        
        dismissAnimation()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        delegate?.didTouchCancelButton(self)
        
        dismissAnimation()
    }
}

extension NoticeView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
