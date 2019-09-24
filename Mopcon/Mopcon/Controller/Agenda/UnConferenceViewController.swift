//
//  UnConferenceViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/24.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class UnConferenceViewController: MPBaseSessionViewController {

    private var sessionList: [SessionList] = []
    
    var selectedIndex = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUnconf()
    }
    
    func fetchUnconf() {
        
        UnconfProvider.fetchUnConf(completion: { [weak self] result in
            
            switch result {
                
            case .success(let list):
                
                self?.sessionList = list
                
                self?.throwToMainThreadAsync {
                    
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    // MARK : Tableview Datasource & Tableview Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        guard sessionList.count > 0 else { return 0 }
        
        return sessionList[selectedIndex].period.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sessionList[selectedIndex].period[section].event == "" ? 0 : 72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let breakCell = tableView.dequeueReusableCell(
            withIdentifier: BreakTableViewCell.identifier
        ) as? BreakTableViewCell else {
            
            return nil
        }
        
        let sessionObject = sessionList[selectedIndex].period[section]
        
        breakCell.updateUI(
            startDate: DateFormatter.string(for: sessionObject.startedAt, formatter: "HH:mm"),
            endDate: DateFormatter.string(for: sessionObject.endedAt, formatter: "HH:mm"),
            event: sessionObject.event
        )
        
        return breakCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sessionList[selectedIndex].period[section].room.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let conferenceCell = tableView.dequeueReusableCell(
            withIdentifier: ConferenceTableViewCell.identifier,
            for: indexPath
        ) as? ConferenceTableViewCell else {
            
                return UITableViewCell()
        }
        
        let room = sessionList[selectedIndex].period[indexPath.section].room[indexPath.row]
        
        conferenceCell.updateUI(room: room)
        
        return conferenceCell
    }
}
