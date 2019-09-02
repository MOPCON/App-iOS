//
//  GameLevelCell.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2019/8/15.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class GameStageCell: UITableViewCell {

    @IBOutlet weak var checkImage: UIImageView!
    
    @IBOutlet weak var stageNameLabel: UILabel!
    
    private var cellView: UIView?
    
    private let animationKey: String = "AnimationKey"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView = contentView.subviews.first
        
        cellView?.layer.borderWidth = 1
    }
    
    func updateUI(isComplete: Bool) {
        // change check image and backgroundColor and borderColor
        checkImage.image = isComplete ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck")
        
        if isComplete {
            
            hightlightStateLayout()
            
        } else {
            
            unHightlightStateLayout()
        }
    }
    
    private func hightlightStateLayout() {
        
        cellView?.backgroundColor = UIColor.azure?.withAlphaComponent(0.3)
        
        cellView?.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func unHightlightStateLayout() {
        
        cellView?.backgroundColor = UIColor.clear
        
        cellView?.layer.borderColor = UIColor.azure?.cgColor
    }
    
    func startTimer() {
        
        let backgroudColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        
        backgroudColorAnimation.fromValue = UIColor.clear
        
        backgroudColorAnimation.toValue = UIColor.azure?.withAlphaComponent(0.3).cgColor
        
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        
        borderColorAnimation.fromValue = UIColor.azure?.cgColor
        
        borderColorAnimation.toValue = UIColor.clear.cgColor
        
        let groupAnimation = CAAnimationGroup()
        
        groupAnimation.animations = [backgroudColorAnimation, borderColorAnimation]
        
        groupAnimation.duration = 1.0
        
        groupAnimation.autoreverses = true
        
        groupAnimation.repeatCount = Float.infinity
        
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        cellView?.layer.add(groupAnimation, forKey: animationKey)
    }
    
    func stopTimer() {
        
        cellView?.layer.removeAnimation(forKey: animationKey)
    }
}
