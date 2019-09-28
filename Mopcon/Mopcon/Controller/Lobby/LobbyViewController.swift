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
    
//    @IBAction func selectedLanguage(sender: UIButton) {
//        
//        switch sender.currentTitle {
//            
//        case "中文":
//            
//            UserDefaults.standard.set(Language.chinese.rawValue, forKey: "language")
//            
//        case "EN":
//            
//            UserDefaults.standard.set(Language.english.rawValue, forKey: "language")
//            
//        default:
//            
//            return
//        }
//        
//        language = CurrentLanguage.getLanguage()
//        
//        updateUI()
//    }
//    
//    @IBAction func moreNews(_ sender: UIButton) {
//        
//        tabBarController?.selectedIndex = 3
//    }
    
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
        
        cells[indexPath.row].manipulateCell(cell)
        
        return cell
    }
}

extension LobbyViewController: UITableViewDelegate {
    
    
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
    
    func manipulateCell(_ cell: UITableViewCell) {
        
        switch self {
            
        case .banner(let banners):
            
            guard let bannerCell = cell as? LobbyBannerCell else { return }
            
            bannerCell.imageUrls = banners
        
        case .news(let news):
            
            guard let newsCell = cell as? LobbyNewsCell else { return }
            
            newsCell.news = news
            
        case .session: break
            
        }
    }
}
