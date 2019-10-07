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
    
    var observer: NSKeyValueObservation!
    
    var selectedIndex = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUnconf()
        
        observer = FavoriteManager.shared.observe(
            \.unconfIds,
            changeHandler: { [weak self] _, _ in
            
                self?.tableView.reloadData()
        })
        
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
        
        let conferenceCell = tableView.dequeueReusableCell(
            withIdentifier: ConferenceTableViewCell.identifier,
            for: indexPath
        )
        
        return conferenceCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let conferenceCell = cell as? ConferenceTableViewCell else { return }
        
        let unconfIds = FavoriteManager.shared.fetchUnconfIds()
        
        if unconfIds.contains(sessionList[selectedIndex].period[indexPath.section].room[indexPath.row].sessionId) {
            
            sessionList[selectedIndex].period[indexPath.section].room[indexPath.row].isLiked = true
            
        } else {
            
            sessionList[selectedIndex].period[indexPath.section].room[indexPath.row].isLiked = false
        }
        
        conferenceCell.updateUI(room: sessionList[selectedIndex].period[indexPath.section].room[indexPath.row])
        
        conferenceCell.delegate = self
    }
}

extension UnConferenceViewController: ConferenceTableViewCellDelegate {
    
    func likeButtonDidTouched(_ cell: ConferenceTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        sessionList[selectedIndex].period[indexPath.section].room[indexPath.row].isLiked = !sessionList[selectedIndex].period[indexPath.section].room[indexPath.row].isLiked
        
        let room = sessionList[selectedIndex].period[indexPath.section].room[indexPath.row]
        
        if room.isLiked {
            
            FavoriteManager.shared.addUnconfId(id: room.sessionId)
            
        } else {
            
            FavoriteManager.shared.removeUnconfId(id: room.sessionId)
        }
    }
}
