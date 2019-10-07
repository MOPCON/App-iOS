//
//  FavoriteViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/24.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class FavoriteViewController: MPBaseSessionViewController {

    private enum ConferenceType {
        
        case session([Room])
        
        case unconf([Room])
        
        func rooms() -> [Room] {
            
            switch self {
            
            case .session(let rooms), .unconf(let rooms): return rooms
            
            }
        }
        
        func title() -> String {
            
            switch self {
                
            case .session: return "議程"
            
            case .unconf: return "交流場次"
            
            }
        }
        
        func remove(id: Int) {
            
            switch self {
                
            case .session:
            
                FavoriteManager.shared.removeSessionId(id: id)
                
            case .unconf:
            
                FavoriteManager.shared.removeUnconfId(id: id)
            }
        }
    }
    
    @IBOutlet weak var emptyView: UIView!
    
    var selectedDate: Int? {
        
        didSet {
            
            updateData()
        }
    }
    
    private var viewState: ViewState<[FavoriteViewController.ConferenceType]> = .empty {
        
        didSet {
            
            switch viewState {
        
            case .empty:
                
                tableView.isHidden = true
                
                emptyView.isHidden = false
                
            case .normal(_):
                
                tableView.isHidden = false
            
                emptyView.isHidden = true
                
                tableView.reloadData()
            }
        }
    }
    
    private var datas: [ConferenceType] {
                
        switch viewState {
            
        case .empty: return []

        case .normal(let datas): return datas
    
        }
    }
    
    
    private let dateFormate = "MM/dd HH:mm"
    
    private var sessionsObserver: NSKeyValueObservation!
    
    private var unconfsObserver: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sessionsObserver = FavoriteManager.shared.observe(
            \.sessionIds,
            options: [.initial, .new],
            changeHandler: { [weak self] _, _ in
            
            self?.updateData()
        })
        
        unconfsObserver = FavoriteManager.shared.observe(
            \.unconfIds,
            options: [.initial, .new],
            changeHandler: { [weak self] _, _ in
                   
           self?.updateData()
       })
    }
    
    private func updateData() {
        
        guard let selectedDate = selectedDate else {
            
            viewState = .empty
            
            return
        }
        
        let sessions: [Room] = FavoriteManager
            .shared
            .sessions
            .map({ room in
                
                var tempRoom = room
                
                tempRoom.isLiked = true
                
                return tempRoom
            })
            .filter({ return $0.startedAt > selectedDate && $0.startedAt < (selectedDate + 86400) })
            .sorted(by: { $0.startedAt < $1.startedAt })
        
        let unconfs: [Room] = FavoriteManager
            .shared
            .unconfs
            .map({ room in
                
                var tempRoom = room
                
                tempRoom.isLiked = true
                
                return tempRoom
            })
            .filter({ return $0.startedAt > selectedDate && $0.startedAt < (selectedDate + 86400) })
            .sorted(by: { $0.startedAt < $1.startedAt })
        
        var tempDatas: [FavoriteViewController.ConferenceType] = []
        
        if sessions.count > 0 {

            tempDatas.append(.session(sessions))
        }

        if unconfs.count > 0 {

            tempDatas.append(.unconf(unconfs))
        }
        
        if tempDatas.count > 0 {
            
            viewState = .normal(tempDatas)
            
        } else {
            
            viewState = .empty
        }
    }
    
    //MARK: - UITableViewDataSource & UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas[section].rooms().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConferenceTableViewCell.identifier, for: indexPath)
        
        guard let conferenceCell = cell as? ConferenceTableViewCell else { return cell }
            
        conferenceCell.updateUI(
            room: datas[indexPath.section].rooms()[indexPath.row],
            dateFormate: dateFormate
        )
        
        conferenceCell.delegate = self
        
        return conferenceCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return datas[section].title()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.textColor = UIColor.white
        
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 18)
        
        headerView.tintColor = UIColor.clear
    }
}

extension FavoriteViewController: ConferenceTableViewCellDelegate {
    
    func likeButtonDidTouched(_ cell: ConferenceTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        datas[indexPath.section].remove(
            id: datas[indexPath.section].rooms()[indexPath.row].sessionId
        )
    }
}
