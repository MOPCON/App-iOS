//
//  SessionsViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/20.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class SessionsViewController: MPBaseSessionViewController {

    var sessions: [Session] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

// MARK : Tableview Datasource & Tableview Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sessions.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sessions[section].room.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sessions[section].event == "" ? 0 : 72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let breakCell = tableView.dequeueReusableCell(
            withIdentifier: BreakTableViewCell.identifier
        ) as? BreakTableViewCell else {
            
            return nil
        }
        
        let sessionObject = sessions[section]
        
        breakCell.updateUI(
            startDate: DateFormatter.string(for: sessionObject.startedAt, formatter: "HH:mm"),
            endDate: DateFormatter.string(for: sessionObject.endedAt, formatter: "HH:mm"),
            event: sessionObject.event
        )
        
        return breakCell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let conferenceCell = tableView.dequeueReusableCell(
            withIdentifier: ConferenceTableViewCell.identifier,
            for: indexPath
        ) as? ConferenceTableViewCell else {
            
                return UITableViewCell()
        }
        
        let room = sessions[indexPath.section].room[indexPath.row]
        
        conferenceCell.updateUI(room: room)
        
        return conferenceCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(
            at: indexPath,
            animated: false
        )
        
        let agendaStoryboard = UIStoryboard(
            name: "Agenda",
            bundle: nil
        )
        
        if #available(iOS 13.0, *) {
            
            guard let detailVC = agendaStoryboard.instantiateViewController(
                identifier: ConferenceDetailViewController.identifier
            ) as? ConferenceDetailViewController else {
                
                return
            }
            
            detailVC.sessionId = sessions[indexPath.section].room[indexPath.row].sessionId
            
            show(detailVC, sender: nil)
            
        } else {
            
            let detailVC = agendaStoryboard.instantiateViewController(
                withIdentifier: ConferenceDetailViewController.identifier
            )
            
            show(detailVC, sender: nil)
        }
    }
}
