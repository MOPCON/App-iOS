//
//  StageViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/30.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class StageViewController: MPBaseViewController {

    @IBOutlet weak var stageImageView: UIImageView!
    
    @IBOutlet weak var stageTitleLabel: UILabel!
    
    @IBOutlet weak var stageDetailLabel: UILabel!
    
    @IBOutlet weak var qrCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qrCodeButton.layer.cornerRadius = 6
        
        qrCodeButton.layer.borderColor = UIColor.azure?.cgColor
        
        qrCodeButton.layer.borderWidth = 1
        
        stageImageView.layer.cornerRadius = 6
        
        stageImageView.layer.borderColor = UIColor.azure?.cgColor
        
        stageImageView.layer.borderWidth = 1
    }
    
    @IBAction func openQRCodeScanner() {
        
    }
    
}
