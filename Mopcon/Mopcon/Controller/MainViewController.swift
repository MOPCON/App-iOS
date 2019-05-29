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

enum SectionName: Equatable {
    
    case Banner([Carousel.Payload])
    
    case News(News.Payload?)
    
    case Grid([GridSectionName])
    
    case Language
    
    func numberOfItems() -> Int {
        
        switch self {
            
        case .Banner: return 1
            
        case .News: return 1
                
        case .Grid(let datas): return datas.count
                    
        case .Language: return 1
            
        }
    }
    
    func cellIdentifier() -> String {
        
        switch self {
            
        case .Banner: return CollectionViewCellKeyManager.bannerCell
            
        case .News: return CollectionViewCellKeyManager.newsCell
            
        case .Grid: return CollectionViewCellKeyManager.gridCell
            
        case .Language: return CollectionViewCellKeyManager.languageCell
            
        }
    }
    
    static func == (lhs: SectionName, rhs: SectionName) -> Bool {
        
        return true
    }
}

enum GridSectionName: Int {
    
    case Agenda = 0
    
    case MySchedule
    
    case Communication
    
    case Mission
    
    case Sponsor
    
    case Speaker
    
    case Group
    
    case News
    
    func gridImage() -> String {
        
        switch self {
            
        case .Agenda: return "Agenda"
        
        case .MySchedule: return "Schedule"
        
        case .Communication: return "Communication"
        
        case .Mission: return "Field Game"
        
        case .Sponsor: return "Sponsor"
        
        case .Speaker: return "Speaker"
        
        case .Group: return "Group"
        
        case .News: return "News"
        
        }
    }
    
    func gridTitle() -> String {
        
        switch self {
            
        case .Agenda: return "議程"
            
        case .MySchedule: return "我的行程"
            
        case .Communication: return "交流場次"
            
        case .Mission: return "大地遊戲"
            
        case .Sponsor: return "贊助廠商"
            
        case .Speaker: return "講者"
            
        case .Group: return "社群"
            
        case .News: return "最新消息"
            
        }
    }
    
    func segue() -> String {
        
        switch self {
            
        case .Agenda: return SegueIDManager.performAgenda
            
        case .MySchedule: return SegueIDManager.performMySchedule
            
        case .Communication: return SegueIDManager.performCommunication
            
        case .Mission: return SegueIDManager.performMission
            
        case .Sponsor: return SegueIDManager.performSponsors
            
        case .Speaker: return SegueIDManager.performSpeaker
            
        case .Group: return SegueIDManager.performCommunity
            
        case .News: return SegueIDManager.performNews
            
        }
    }
}

class MainViewController: UIViewController {

    var language = CurrentLanguage.getLanguage()
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
//    let gridImage = ["Agenda","Schedule","Communication","Field Game","Sponsor","Speaker","Group","News"]
//    let gridTitle = ["議程","我的行程","交流場次","大地遊戲","贊助廠商","講者","社群","最新消息"]
    
    var datas: [SectionName] = [
        .Banner([]),
        .News(nil),
        .Grid([.Agenda, .MySchedule, .Communication, .Mission, .Sponsor, .Speaker, .Group, .News]),
        .Language
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundView = UIImageView(image: UIImage(named: "bgMainPage"))
        mainCollectionView.backgroundView?.contentMode = .scaleAspectFill
    
        getNews()
        getBannerData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNews() {
        
        NewsAPI.getAPI(url: MopconAPI.shared.news) { [weak self] (news, error) in
            
            if error != nil {
            
                print(error!.localizedDescription)
                
                return
            }
            
            if let news = news,
               let index = self?.datas.firstIndex(of: .News(nil)) {
                
                if news.isEmpty {
                    return
                }
                
                self?.datas[index] = .News(news.first)
                
                DispatchQueue.main.async {
                    self?.mainCollectionView.reloadSections(IndexSet.init(integer: index))
                }
            }
        }
    }
    
    func getBannerData() {
        
        CarouselAPI.getAPI(url: MopconAPI.shared.carousel) { [weak self] (bannerData, error) in
        
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = bannerData,
               let index = self?.datas.firstIndex(of: .Banner([])) {
                
                self?.datas[index] = .Banner(data)
                
                DispatchQueue.main.async {
                    self?.mainCollectionView.reloadSections(IndexSet.init(integer: index))
                }
            }
        }
    }
    
    @objc func selectedLanguage(sender:CustomCornerButton) {
        
        switch sender.currentTitle {
        case "中文":
            UserDefaults.standard.set(Language.chinese.rawValue, forKey: "language")
        case "English":
            UserDefaults.standard.set(Language.english.rawValue, forKey: "language")
        default:
            return
        }
        
        self.language = CurrentLanguage.getLanguage()
        
        mainCollectionView.reloadData()
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datas[section].numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionItem = datas[indexPath.section]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionItem.cellIdentifier(), for: indexPath)
        
        switch sectionItem {
            
        case .Banner(let bannerData):
            let bannerCell = cell as! BannerCollectionViewCell
            bannerCell.bannerImageCollectionView.delegate = bannerCell
            bannerCell.bannerImageCollectionView.dataSource = bannerCell
            bannerCell.bannerData = bannerData
            return bannerCell
        
        case .News(let firstNews):
            let newsCell = cell as! NewsCollectionViewCell
            if let news = firstNews {
                newsCell.updateUI(news: news)
            }
            return newsCell
        
        case .Grid(let gridItems):
            let gridCell = cell as! GridCollectionViewCell
            switch language {
            case Language.chinese.rawValue:
                gridCell.updateUI(imageName: gridItems[indexPath.row].gridImage(), title: gridItems[indexPath.row].gridTitle())
            case Language.english.rawValue:
                gridCell.updateUI(imageName: gridItems[indexPath.row].gridImage(), title: gridItems[indexPath.row].gridTitle())
            default:
                break
            }
            return gridCell
        
        case .Language:
            let language = cell as! LanguageCollectionViewCell
            language.chineseButton.addTarget(self, action: #selector(selectedLanguage(sender:)), for: .touchUpInside)
            language.englishButton.addTarget(self, action: #selector(selectedLanguage(sender:)), for: .touchUpInside)
            return language
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewCellKeyManager.collectionViewHeader,
            for: indexPath
        ) as! MopconHeader
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch datas[section] {
        
        case .Banner: return CGSize(width: self.view.frame.width, height: self.view.frame.height * (127/667))
        
        default: return CGSize(width: 0, height: 0)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch datas[indexPath.section] {
            
        case .News: performSegue(withIdentifier: SegueIDManager.performNews, sender: nil)
            
        case .Grid(let gridItems): performSegue(withIdentifier: gridItems[indexPath.row].segue(), sender: nil)
            
        default: break
            
        }
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch datas[section] {
            
        case .Banner: return UIEdgeInsets.init(top: self.view.frame.height * (8/667), left: 0, bottom: self.view.frame.height * (8/667), right: 0)
        
        default: return UIEdgeInsets.init(
            top: self.view.frame.height * (8/667),
            left: self.view.frame.width * (20/375),
            bottom: self.view.frame.height * (8/667),
            right: self.view.frame.width * (20/375)
        )
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return self.view.frame.height * (16/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return self.view.frame.width * (8/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        switch datas[indexPath.section] {
        
        case .Banner: return CGSize(width: self.view.frame.width * 375/375, height: self.view.frame.height * (168/667))
        
        case .News: return CGSize(width: self.view.frame.width * 336/375, height: self.view.frame.height * (72/667))
        
        case .Language: return CGSize(width: self.view.frame.width * 336/375, height: 36)
        
        default: return CGSize(width: self.view.frame.width * 160/375, height: self.view.frame.width * 160/375)
        
        }
    }
}
