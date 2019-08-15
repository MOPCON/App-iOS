//
//  ConferenceDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ConferenceDetailViewController: UIViewController {
    
    var key:String?
    
    var agenda:Schedule.Payload.Agenda.Item.AgendaContent?
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    
    @IBOutlet weak var speakerName: UILabel!
    
    @IBOutlet weak var speakerJob: UILabel!
    
    @IBOutlet weak var scheduleInfoLabel: UILabel!
    
    @IBOutlet weak var addToMyScheduleButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sponsorTitleLabel: UILabel!
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    
    @IBOutlet weak var sponsorLabel: UILabel!
    
    @IBAction func addToMySchedule(_ sender: UIBarButtonItem) {
        
        guard let agenda = agenda,let key = key  else {
            return
        }
        
        if sender.image == #imageLiteral(resourceName: "dislike_24"){
    
            MySchedules.add(agenda: agenda, forKey: key)
            
            sender.image = #imageLiteral(resourceName: "like_24")
            
        } else {
        
            MySchedules.remove(agenda: agenda, forKey: key)
            
            sender.image = #imageLiteral(resourceName: "dislike_24")
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
        
            navigationItem.title = "Agenda"
            
            sponsorTitleLabel.text = "Sponsor"
        }
        
        if let agenda = agenda {
        
            updateUI(agenda: agenda)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        speakerImageView.makeCircle()

        sponsorImageView.makeCircle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func updateUI(agenda:Schedule.Payload.Agenda.Item.AgendaContent) {
        
        if let picture = agenda.picture {
        
            speakerImageView.kf.setImage(with: URL(string: picture))
        }
        
        if MySchedules.checkRepeat(scheduleID: agenda.schedule_id) {
        
            addToMyScheduleButtonItem.image = #imageLiteral(resourceName: "like_24")
        }

        
        
        let language = CurrentLanguage.getLanguage()
        
        switch language {
        
        case Language.chinese.rawValue:
        
            scheduleInfoLabel.text = agenda.schedule_info
            
            typeLabel.text = agenda.category
            
            topicLabel.text = agenda.schedule_topic
            
            speakerName.text = agenda.name
            
            speakerJob.text = "\(agenda.job ?? "")@\(agenda.company ?? "")"
        
        case Language.english.rawValue:
        
            scheduleInfoLabel.text = agenda.schedule_info_en
            
            topicLabel.text = agenda.schedule_topic_en
            
            typeLabel.text = agenda.category
            
            speakerName.text = agenda.name_en
            
            speakerJob.text = "\(agenda.job ?? "")@\(agenda.company ?? "")"
        
        default:
        
            break
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
