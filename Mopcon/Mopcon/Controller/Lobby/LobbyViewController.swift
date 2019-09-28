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
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        fetchHome()
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
    }
    
    //MARK: - API
    private func fetchHome() {
        
        HomeProvider.fetchHome(completion: { [weak self] result in
            
            switch result {
                
            case .success(let home):
                
                self?.home = home
                
                self?.cells = [
                    .banner( home.banner.map({ $0.img }) ),
                    .news( home.news.map({ $0.description }) ),
                    .session
                ]
                
                self?.throwToMainThreadAsync {
                    
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}

extension LobbyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cells[indexPath.row].identifier(),
            for: indexPath
        )
        
        cells[indexPath.row].manipulateCell(cell, controller: self)
        
        return cell
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

private enum CellType: CaseIterable {
    
    static var allCases: [CellType] = [
        .banner([]),
        .news([]),
        .session
    ]

    typealias AllCases = [CellType]
    
    case banner([String])
    
    case news([String])
    
    case session
    
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
            
        case .session: break
            
        }
    }
}
