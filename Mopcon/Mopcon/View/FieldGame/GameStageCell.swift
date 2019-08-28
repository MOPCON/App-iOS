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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView = contentView.subviews.first
    }

    private var timer : Timer?
    
    func updateUI(isComplete: Bool) {
        // change check image and backgroundColor and borderColor
        checkImage.image = isComplete ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck")
        
        if isComplete {
            
//            cellView?.layer.sublayers?.removeAll()
            
            cellView?.backgroundColor = UIColor.azure?.withAlphaComponent(0.3)
            
            cellView?.layer.borderWidth = 0
            
        } else {
            
            cellView?.layer.borderWidth = 1
            
            cellView?.layer.borderColor = UIColor.azure?.cgColor
        }
    }
    
    private func startTimer() {
        
        timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] _ in
        
            UIView.animate(withDuration: 0.5, animations: {
                
                DispatchQueue.main.async {
                    
                    self?.cellView?.backgroundColor = .clear
                    
                    self?.cellView?.layer.borderWidth = 1
                    
                    self?.cellView?.layer.borderColor = UIColor.azure?.cgColor
                }
                
            }, completion: { finished in
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    DispatchQueue.main.async {
                        
                        self?.cellView?.layer.borderWidth = 0
                        
                        self?.cellView?.backgroundColor = UIColor.azure?.withAlphaComponent(0.3)
                    }
                    
                }, completion: nil)
            })
        })
    }
    
    private func stopTimer() {
        
        timer?.invalidate()
        
        timer = nil
    }
}
