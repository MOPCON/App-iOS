//
//  AgendaViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController {
    
    @IBOutlet weak var goToCommunicationVCButton: CustomCornerButton!
    
    @IBOutlet weak var dateSelectionView: SelectionView!
    
    @IBOutlet weak var scheduleSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var agendaTableView: UITableView!
    
    private var key = UserDefaultsKeys.dayOneSchedule
    
    private var selectedSchedule = [Schedule.Payload.Agenda.Item]()
    
    private var selectedAgenda:Schedule.Payload.Agenda.Item.AgendaContent?
    
    private var mySchedule = MySchedules.get(forKey: UserDefaultsKeys.dayOneSchedule)
    
    private var schedule_day1 = [Schedule.Payload.Agenda.Item]()
    
    private var schedule_day2 = [Schedule.Payload.Agenda.Item]()
    
    private var isAgenda: Bool = true
    
    private let spinner = LoadingTool.setActivityindicator()
    
    @IBAction func chooseScheduleAction(_ sender: UISegmentedControl) {
        
        isAgenda = (sender.selectedSegmentIndex == 0)
        
        agendaTableView.reloadData()
        
    }
    
    @IBAction func goToCommunicationVC(_ sender: UIButton) {
        let communicationVC = UIStoryboard(name: "Communication", bundle: nil).instantiateViewController(withIdentifier: StoryboardIDManager.communicationVC) as! CommunicationViewController
        
        navigationController?.pushViewController(communicationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agendaTableView.delegate = self
        
        agendaTableView.dataSource = self
        
        agendaTableView.separatorStyle = .none
        
        dateSelectionView.dataSource = self
        
        scheduleSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], for: .selected)
        
        getSchedule()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            
            self.goToCommunicationVCButton.setTitle("Communication", for: .normal)
            
            self.navigationItem.title = "Agenda"
            
            scheduleSegmentedControl.setTitle("Schedule", forSegmentAt: 0)
            
            scheduleSegmentedControl.setTitle("Favorite", forSegmentAt: 1)
        }
        
        mySchedule = MySchedules.get(forKey: key)
        
        agendaTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIDManager.performConferenceDetail {
            
            if let vc = segue.destination as? ConferenceDetailViewController {
                
                vc.key = key
                
                vc.agenda = selectedAgenda
            }
        }
    }
    
    func getSchedule() {
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        view.addSubview(spinner)
        
        ScheduleAPI.getAPI(url: MopconAPI.shared.schedule) { [weak self] (payload, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
                self?.spinner.removeFromSuperview()
                
                return
            }
            
            if let payload = payload {
                
                self?.schedule_day1 = payload.agenda[0].items
                
                self?.schedule_day2 = payload.agenda[1].items
                
                self?.selectedSchedule = self?.schedule_day1 ?? []
                
                DispatchQueue.main.async {
                
                    self?.agendaTableView.reloadData()
                    
                    self?.spinner.removeFromSuperview()
                }
            }
        }
    }
    
}


// MARK : Tableview Datasource & Tableview Delegate
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return isAgenda ? selectedSchedule.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isAgenda ? selectedSchedule[section].agendas.count : mySchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let scheduleID = isAgenda ? selectedSchedule[indexPath.section].agendas[indexPath.row].schedule_id : mySchedule[indexPath.row].schedule_id
        
        if scheduleID != nil {
            
            let conferenceCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.conferenceCell, for: indexPath) as! ConferenceTableViewCell
            
            let agenda = isAgenda ? selectedSchedule[indexPath.section].agendas[indexPath.row] : mySchedule[indexPath.row]
            
            checkMySchedule(agenda: agenda, sender: conferenceCell.addToMyScheduleButton)
            
            conferenceCell.updateUI(agenda: agenda)
            
            conferenceCell.delegate = self
            
            conferenceCell.index = indexPath
            
            return conferenceCell
        
        } else {
            
            let agenda = selectedSchedule[indexPath.section].agendas[indexPath.row]
            
            let breakCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.breakCell, for: indexPath) as! BreakTableViewCell
            
            breakCell.updateUI(agenda:agenda )
            
            return breakCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedAgenda = selectedSchedule[indexPath.section].agendas[indexPath.row]
        
        performSegue(withIdentifier: SegueIDManager.performConferenceDetail, sender: nil)
    }
    
    func checkMySchedule(agenda:Schedule.Payload.Agenda.Item.AgendaContent ,sender: UIButton) {
        for schedule in mySchedule {
            
            if schedule.schedule_topic == agenda.schedule_topic {
                
                sender.setImage(#imageLiteral(resourceName: "like_24"), for: .normal)
                
                return
            }
        }
        
        sender.setImage(#imageLiteral(resourceName: "dislike_24"), for: .normal)
    }
}

extension AgendaViewController: WhichCellButtonDidTapped {
    
    func whichCellButtonDidTapped(sender: UIButton, index: IndexPath) {
        
        let agenda = selectedSchedule[index.section].agendas[index.row]
   
        if sender.image(for: .normal) == #imageLiteral(resourceName: "like_24") {
            
            MySchedules.add(agenda: agenda, forKey: agenda.date!)
            
        } else if sender.image(for: .normal) == #imageLiteral(resourceName: "dislike_24"){
            
            MySchedules.remove(agenda: agenda, forKey: agenda.date!)
        }
        
        mySchedule = MySchedules.get(forKey: key)
        
        agendaTableView.reloadData()
    }
    
}

extension AgendaViewController: SelectionViewDataSource {
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String {
        
        return (index == 0) ? "10/19" : "10/20"
    }
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
        
        selectedSchedule = (index == 0) ? schedule_day1 : schedule_day2
        
        key = (index == 0) ? UserDefaultsKeys.dayOneSchedule : UserDefaultsKeys.dayTwoSchedule
        
        mySchedule = MySchedules.get(forKey: key)
        
        agendaTableView.reloadData()
    }
}
