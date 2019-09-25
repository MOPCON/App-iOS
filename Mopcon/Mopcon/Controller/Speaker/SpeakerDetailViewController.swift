//
//  SpeakerDetailViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/3.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakerDetailViewController: MPBaseViewController {
    
    @IBOutlet weak var speakerView: SpeakerView!
    
    @IBOutlet weak var speakerDetailView: SpeakerDetailView!
    
    @IBOutlet weak var talkInfoView: SpeakerTalkInfoView! {
        
        didSet {
        
            talkInfoView.delegate = self
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var speaker:Speaker?
    
    var speaker_schedule:Schedule.Payload.Agenda.Item.AgendaContent?

    var key:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let speaker = speaker {
            updateUI(speaker: speaker)
        }
        
        setupLayout()
        
        findSchedule()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            
            self.navigationItem.title = "Speaker"
        }
    }
    
    private func setupLayout() {
        
        scrollView.addSubview(speakerView)
        
        speakerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(speakerDetailView)
        
        speakerDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(talkInfoView)
        
        talkInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            speakerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            speakerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            speakerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            speakerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            speakerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            speakerDetailView.topAnchor.constraint(equalTo: speakerView.bottomAnchor),
            speakerDetailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            speakerDetailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            talkInfoView.topAnchor.constraint(equalTo: speakerDetailView.bottomAnchor),
            talkInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            talkInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            talkInfoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            
        ])
        
    }
    
    //MARK: - Action
    func findSchedule() {

//        ScheduleAPI.getAPI(url: MopconAPI.shared.schedule) { [weak self] (payload, error) in
//
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//
//            if let payload = payload, let scheduleID = self?.speaker?.schedule_id {
//                for agenda in payload.agenda {
//                    for item in agenda.items {
//                        for schedule in item.agendas {
//                            if scheduleID == schedule.schedule_id {
//                                self?.speaker_schedule = schedule
//                                self?.key = schedule.date
//                            }
//                        }
//                    }
//                }
//            }
//            
//        }
    }

    func updateUI(speaker: Speaker) {
        
//        speakerView.updateUI(
//            image: speaker.picture,
//            name: speaker.name,
//            job: speaker.job
//        )
//
//        speakerDetailView.updateUI(info: speaker.info)
//
//        talkInfoView.updateUI(
//            topic: speaker.schedule_topic,
//            time: "10:15 - 11:00",
//            position: "R1: 一廳",
//            isCollected: MySchedules.checkRepeat(scheduleID: speaker.schedule_id)
//        )
    }
    
}

extension SpeakerDetailViewController: SpeakerTalkInfoViewDelegate {
    
    func didTouchCollectedButton(_ infoView: SpeakerTalkInfoView) {
        
        guard let schedule = speaker_schedule, let key = key else {
            return
        }
        
        if MySchedules.checkRepeat(scheduleID: schedule.schedule_id) {
            
            MySchedules.remove(agenda: schedule, forKey: key)
        
        } else {
        
            MySchedules.add(agenda: schedule, forKey: key)
        }
    }
}
