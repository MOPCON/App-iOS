//
//  CommunicationViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunicationViewController: MPBaseViewController {
   
    var selectedSchedule = [Schedule_unconf.Payload.Item]()
    
    var schedule_day1 = [Schedule_unconf.Payload.Item]()
    
    var schedule_day2 = [Schedule_unconf.Payload.Item]()
    
    let spinner = LoadingTool.setActivityindicator()

    @IBOutlet weak var dateSelectionView: SelectionView!
    
    @IBOutlet weak var communicationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        dateSelectionView.dataSource = self
        
        getCommunicationAPI()
    }
    
    private func setupTableView() {
        
        communicationTableView.separatorStyle = .none
        
        communicationTableView.delegate = self
        
        communicationTableView.dataSource = self
        
        let communicationCell = UINib(nibName: String(describing: CommunicationConferenceTableViewCell.self), bundle: nil)
        
        let communicationBreakCell = UINib(nibName: String(describing: CommunicationBreakTableViewCell.self), bundle: nil)
        
        communicationTableView.register(communicationCell, forCellReuseIdentifier: CommunicationTableViewCellID.communicationConferenceCell)
        
        communicationTableView.register(communicationBreakCell, forCellReuseIdentifier: CommunicationTableViewCellID.communicationBreakCell)
    }
    
    func getCommunicationAPI() {
        spinner.center = view.center
        
        spinner.startAnimating()
        
        self.view.addSubview(spinner)
        
        Schedule_unconfAPI.getAPI(url: MopconAPI.shared.schedule_unconf) { [weak self] (payload, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                
                self?.spinner.removeFromSuperview()
                
                return
            }
            
            if let payload = payload {
                
                self?.schedule_day1 = payload[0].items
                
                self?.schedule_day2 = payload[1].items
                
                self?.selectedSchedule = self?.schedule_day1 ?? []
                
                DispatchQueue.main.async {
                    self?.communicationTableView.reloadData()
                    
                    self?.spinner.removeFromSuperview()
                }
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            
            navigationItem.title = "Communication"
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
extension CommunicationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let schedule = selectedSchedule[indexPath.row]
        
        switch schedule.type {
            
        case "others":
            
            let communicationBreakCell = tableView.dequeueReusableCell(withIdentifier: CommunicationTableViewCellID.communicationBreakCell, for: indexPath) as! CommunicationBreakTableViewCell
            communicationBreakCell.updateUI(schedule: schedule)
            
            return communicationBreakCell
            
        default:
            
            let communicationConferenceCell = tableView.dequeueReusableCell(withIdentifier: CommunicationTableViewCellID.communicationConferenceCell, for: indexPath) as! CommunicationConferenceTableViewCell
            
            communicationConferenceCell.updateUI(schedule: schedule)
            
            return communicationConferenceCell
        }
        
    }
}

extension CommunicationViewController: SelectionViewDataSource {
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String {
        
        return (index == 0) ? "10/19" : "10/20"
    }
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
        
        selectedSchedule = (index == 0) ? schedule_day1 : schedule_day2
        
        communicationTableView.reloadData()
    }
}
