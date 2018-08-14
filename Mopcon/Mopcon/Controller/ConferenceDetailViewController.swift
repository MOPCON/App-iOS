//
//  ConferenceDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ConferenceDetailViewController: UIViewController {
    
    var agenda:Schedule.Payload.Agenda.Item.AgendaContent?
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerJob: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
        if let agenda = agenda {
            updateUI(agenda: agenda)
        }
    }
    
    func updateUI(agenda:Schedule.Payload.Agenda.Item.AgendaContent) {
        self.speakerImageView.getImage(address: agenda.picture)
        self.typeLabel.text = agenda.type
        self.topicLabel.text = agenda.schedule_topic
        self.speakerName.text = agenda.name
        self.speakerJob.text = agenda.job
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
