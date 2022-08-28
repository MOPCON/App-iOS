//
//  ViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/1.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum Language:String {
    
    case chinese = "Chinese"
    
    case english = "English"
}

class LobbyViewController: MPBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chineseButton: UIButton!
    
    @IBOutlet weak var englishButton: UIButton!

    private var home: Home?
    
    private var cells: [CellType] = []
    
    var sessionObserve: NSKeyValueObservation!
    
    var unconfObserve: NSKeyValueObservation!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        fetchHome()
    }
    
    private func observerSession() {
        
        sessionObserve = FavoriteManager.shared.observe(
            \.sessionIds,
            options: [.initial, .new],
            changeHandler: { [weak self] _, _ in
            
            self?.updateData()
        })
    }
    
    func updateData() {
        
        repeat
        {
            if(cells.last?.identifier()==ConferenceTableViewCell.identifier ||
               cells.last?.identifier()==LobbySessionCell.identifier)
            {
                cells.removeLast()
            }
            else
            {
                break;
            }
        }while(true)
                
//        if case .session(_) = cells.last {
//            cells.removeLast()
//        }
        
        let tempRooms = FavoriteManager.shared.sessions
        
        let rooms: [Room] = tempRooms.compactMap({ room in
                
//            if room.startedAt < Int(Date().timeIntervalSince1970) {
//
//                return nil
//            }
            
            var tempRoom = room
            
            tempRoom.isLiked = true
            
            return tempRoom
        })
        .sorted(by: { $0.startedAt < $1.startedAt })
        
        if(rooms.count<=0)
        {
            cells.append(.session(rooms))
        }
        else
        {
            for room in rooms
            {
                cells.append(.session([room]))
            }
        }
       
        
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - Layout and Setting
    private func setupTableView() {
        
        CellType.allCases.forEach({ tableView.registerNib(identifier: $0.identifier()) })
        
        tableView.registerNib(identifier: ConferenceTableViewCell.identifier)
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Method
    
    private func didSelectSession(sessionId:Int)
    {
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
            
            detailVC.conferenceType = .session(sessionId)
            
            show(detailVC, sender: nil)
            
        } else {
            
            guard let detailVC = agendaStoryboard.instantiateViewController(
                withIdentifier: ConferenceDetailViewController.identifier
            ) as? ConferenceDetailViewController else {
                    
                    return
            }
            
            detailVC.conferenceType = .session(sessionId)
            
            show(detailVC, sender: nil)
        }
    }
    
    private func hasFavoriteRoom() -> Bool {
        
        var result = false
        
        if(cells.count>2)
        {
            let cellType = cells[2]
            
            switch cellType
            {
                case .session(let rooms):
       
                    if(rooms.count>0)
                    {
                        result = true
                    }
            case .banner(_):
                break
            case .news(_):
                break
            }
        }
        
        return result;
    }
    
    //MARK: - API
    private func fetchHome() {
        
        HomeProvider.fetchHome(completion: { [weak self] result in
            
            switch result {
                
            case .success(let home):
                
                self?.home = home
                
                self?.cells = [
                    .banner( home.banner.map({ $0.img }) ),
                    .news( home.news )
                ]
                
                self?.throwToMainThreadAsync {
                    
                    self?.tableView.reloadData()
                    
                    self?.observerSession()
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}

extension LobbyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==2 && self.hasFavoriteRoom())
        {
            return 20
        }
        else
        {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var label = Optional<UILabel>.none
        
        if(section==2 && self.hasFavoriteRoom())
        {
            label = UILabel()
            
            label?.text  = "你最喜愛的戰艦即將進站"
            
            label?.textColor = UIColor.white
        }
        
        return label
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if(indexPath.section>=2 && self.hasFavoriteRoom()==true)
        {
            cell = tableView.dequeueReusableCell(
                withIdentifier: ConferenceTableViewCell.identifier,
                for: indexPath
            )
            
            switch cells[indexPath.section]
            {
                case .session(let rooms):
       
                    if(rooms.count>0)
                    {
                        if let conferenceTableViewCell = cell as? ConferenceTableViewCell
                        {
                            conferenceTableViewCell.delegate = self;
                            conferenceTableViewCell.updateUI(room: rooms[0])
                        }
                            
                    }
                case .banner(_):
                    break
                case .news(_):
                    break
            }
            
            
        }
        else
        {
            cell = tableView.dequeueReusableCell(
                withIdentifier: cells[indexPath.section].identifier(),
                for: indexPath
            )
            
            cells[indexPath.section].manipulateCell(cell, controller: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cells[indexPath.section]
        {
            case .session(let rooms):
                self.didSelectSession(sessionId: rooms[0].sessionId)
            case .banner(_):
                break
            case .news(_):
                break
        }
    }
}

extension LobbyViewController: UITableViewDelegate {
    
}

extension LobbyViewController: LobbyBannerCellDelegate {
    
    func didSelectedIndex(_ cell: LobbyBannerCell, index: Int) {
        
        openURL(home?.banner[index].link)
    }
}

extension LobbyViewController: LobbyNewsCellDelegate {

    func didSelectedCell(_ cell: LobbyNewsCell, index: Int) {
        
        openURL(home?.news[index].link)
    }
    
    func didSelectedShowMoreButton(_ cell: LobbyNewsCell) {
        
        let newsStoryboard = UIStoryboard(
            name: "News",
            bundle: nil
        )
        
        let vc = newsStoryboard.instantiateViewController(
            withIdentifier: NewsViewController.identifier
        )
        
        show(vc, sender: nil)
    }
}

extension LobbyViewController: LobbySessionCellDelegate {
    
    func didSelectedSession(_ cell: LobbySessionCell, sessionId: Int) {
        self.didSelectSession(sessionId: sessionId)
    }
    
    func likeButtonDidTouched(_ cell: LobbySessionCell, id: Int, isLiked: Bool) {
        
        FavoriteManager.shared.removeSession(id: id)
    }
    
    func moreButtonDidTouched(_ cell: LobbySessionCell) {
        
        tabBarController?.selectedIndex = 1
    }
}

extension LobbyViewController: ConferenceTableViewCellDelegate{
    func likeButtonDidTouched(_ cell: ConferenceTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        switch cells[indexPath.section]
        {
            case .session(let rooms):
            FavoriteManager.shared.removeSession(room: rooms.first!)
                
            case .banner(_):
                break
            case .news(_):
                break
        }
        
       
    }
}

private enum CellType: CaseIterable {
    
    static var allCases: [CellType] = [
        .banner([]),
        .news([]),
        .session([])
    ]

    typealias AllCases = [CellType]
    
    case banner([String])
    
    case news([HomeNews])
    
    case session([Room])
    
    func identifier() -> String {
        
        switch self {
            
        case .banner: return LobbyBannerCell.identifier
        
        case .news: return LobbyNewsCell.identifier
            
        case .session: return LobbySessionCell.identifier
            
        }
    }
    
    func manipulateCell(_ cell: UITableViewCell, controller: LobbyViewController) {
        
        switch self {
            
        case .banner(let banners):
            
            guard let bannerCell = cell as? LobbyBannerCell else { return }
            
            bannerCell.imageUrls = banners
            
            bannerCell.delegate = controller
        
        case .news(let news):
            
            guard let newsCell = cell as? LobbyNewsCell else { return }
            
            newsCell.news = news
            
            newsCell.delegate = controller
            
        case .session(let rooms):
            
            guard let sessionCell = cell as? LobbySessionCell else { return }
            
            sessionCell.updateUI(rooms: rooms)
            
            sessionCell.delegate = controller
        }
    }
}
