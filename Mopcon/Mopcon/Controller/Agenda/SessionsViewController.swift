//
//  SessionsViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/20.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class SessionsViewController: MPBaseSessionViewController {

    private var sessions: [Session] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateData(sessions: [Session]) {
        
        self.sessions = sessions
        
        tableView.reloadData()
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
        
        let conferenceCell = tableView.dequeueReusableCell(
            withIdentifier: ConferenceTableViewCell.identifier,
            for: indexPath
        )
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let sessionIds = FavoriteManager.shared.fetchSessionIds()
        
        let id = sessions[indexPath.section].room[indexPath.row].sessionId
        
        if sessionIds.contains(id) {
            
            sessions[indexPath.section].room[indexPath.row].isLiked = true
            
        } else {
            
            sessions[indexPath.section].room[indexPath.row].isLiked = false
        }
        
        guard let conferenceCell = cell as? ConferenceTableViewCell else {
            
            return
        }
        
        conferenceCell.updateUI(room: sessions[indexPath.section].room[indexPath.row])
        
        conferenceCell.delegate = self
    }
}

extension SessionsViewController: ConferenceTableViewCellDelegate {
    
    func likeButtonDidTouched(_ cell: ConferenceTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        sessions[indexPath.section].room[indexPath.row].isLiked = !sessions[indexPath.section].room[indexPath.row].isLiked
        
        var action = ""
        
        let room = sessions[indexPath.section].room[indexPath.row]
        
        if room.isLiked {
            
            action = "add"
            
            FavoriteManager.shared.addSessionId(id: room.sessionId)
            
        } else {
            
            action = "remove"
            
            FavoriteManager.shared.removeSessionId(id: room.sessionId)
        }
        
        FieldGameProvider.modifyFavorate(
            id: room.sessionId,
            action: action,
            completion: { result in
                
                switch result {
                    
                case .success(_):
                    
                    print("success")
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
        
    }
}
