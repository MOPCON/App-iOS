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
    var speaker_schedule:Schedule.Payload.Agenda.Item.AgendaContent?

    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerJobLabel: UILabel!
    @IBOutlet weak var speakerCompanyLabel: UILabel!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var scheduleTopicLabel: UILabel!
    
    @IBAction func addToMySchedule(_ sender: UIButton) {
        findSchedule()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        //把backButton的顏色改成白色
        self.navigationController?.navigationBar.tintColor = UIColor.white
            findSchedule()
        
        if let speaker = speaker {
            updateUI(speaker: speaker)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findSchedule() {
        ScheduleAPI.getAPI(url: MopconAPI.shared.schedule) { (payload, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let payload = payload,let scheduleID = self.speaker?.schedule_id {
                for agenda in payload.agenda {
                    for item in agenda.items {
                        for schedule in item.agendas {
                            if scheduleID == schedule.schedule_id {
                                self.speaker_schedule = schedule
                                MySchedules.add(agenda: schedule, forKey: schedule.date!)
                                return
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateUI(speaker:Speaker.Payload) {
        if let url = URL(string: speaker.picture) {
            speakerImageView.kf.setImage(with: url)
        }
        self.speakerImageView.makeCircle()
        
        let language = CurrentLanguage.getLanguage()
        switch language {
        case Language.chinese.rawValue:
            self.speakerJobLabel.text = speaker.job
            self.speakerCompanyLabel.text = speaker.company
            self.speakerNameLabel.text = speaker.name
            self.infoLabel.text = speaker.info
            self.scheduleTopicLabel.text = speaker.schedule_topic
            self.typeLabel.text = speaker.type
        case Language.english.rawValue:
            self.speakerJobLabel.text = speaker.job
            self.speakerCompanyLabel.text = speaker.company
            self.speakerNameLabel.text = speaker.name_en
            self.infoLabel.text = speaker.info_en
            self.scheduleTopicLabel.text = speaker.schedule_topic_en
            self.typeLabel.text = speaker.type
        default:
            break
        }
    }

}
