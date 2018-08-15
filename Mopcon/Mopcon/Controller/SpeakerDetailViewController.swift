//
//  SpeakerDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/3.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakerDetailViewController: UIViewController {
    
    var speaker:Speaker.Payload?

    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var scheduleTopicLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        //把backButton的顏色改成白色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if let speaker = speaker {
            updateUI(speaker: speaker)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateUI(speaker:Speaker.Payload) {
        self.speakerImageView.getImage(address: speaker.picture)
        self.speakerImageView.makeCircle()
        self.speakerNameLabel.text = speaker.name
        self.infoLabel.text = speaker.info
        self.scheduleTopicLabel.text = speaker.schedule_topic
        self.typeLabel.text = speaker.type
    }

}
