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
    
    enum CellType: CaseIterable {
        
        static var allCases: [LobbyViewController.CellType] = [
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
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var chineseButton: UIButton!
    
    @IBOutlet weak var englishButton: UIButton!

    private var home: Home?
    
    var cells: [CellType] = [
        .banner(["1", "2"]),
        .news(["3", "4"]),
        .session
    ]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        getNews()
        
        getBanner()
    }
    
    //MARK: - Layout and Setting
    private func setupTableView() {
        
        CellType.allCases.forEach({ tableView.registerNib(identifier: $0.identifier()) })
    }
    
    //MARK: - API
    private func getNews() {
        
        NewsAPI.getAPI(url: MopconAPI.shared.news) { [weak self] (news, error) in
           
            guard error == nil else {
            
                print(error!.localizedDescription)
                
                return
            }
            
            if let news = news, !news.isEmpty{
                
                DispatchQueue.main.async {
                
//                    self?.descriptionLabel.text = news.first?.title
                }
            }
        }
    }

    private func getBanner() {
        
        HomeProvider.fetchHome(completion: { [weak self] result in
            
            switch result {
                
            case .success(let home):
                
                self?.home = home
                
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
        
        return cell
    }
}

extension LobbyViewController: UITableViewDelegate {
    
    
}
