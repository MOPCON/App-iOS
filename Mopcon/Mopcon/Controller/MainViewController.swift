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

enum SectionName:Int {
    case Banner = 0
    case News
    case Grid
    case Language
}

enum GridSectionName:Int{
    case Agenda = 0
    case MySchedule
    case Communication
        case Mission
    case Sponsor
    case Speaker
    case Group
    case News
}

class MainViewController: UIViewController {
    
    var firstNews:News.Payload?
    var language = CurrentLanguage.getLanguage()
    var bannerData = [Carousel.Payload]()
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
//    fake Data
        let gridImage = ["Agenda","Schedule","Communication","Field Game","Sponsor","Speaker","Group","News"]
        let gridTitle = ["議程","我的行程","交流場次","大地遊戲","贊助廠商","講者","社群","最新消息"]
    
//    let gridImage = ["Agenda","Schedule","Communication","Sponsor","Speaker","Group","News"]
//    let gridTitle = ["議程","我的行程","交流場次","贊助廠商","講者","社群","最新消息"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundView = UIImageView(image: UIImage(named: "bgMainPage"))
        getNews()
        getBannerData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNews() {
        NewsAPI.getAPI(url: MopconAPI.shared.news) { (news, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let news = news {
                self.firstNews = news[0]
                DispatchQueue.main.async {
                    self.mainCollectionView.reloadData()
                }
            }
        }
    }
    
    func getBannerData() {
        CarouselAPI.getAPI(url: MopconAPI.shared.carousel) { (bannerData, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = bannerData {
                self.bannerData = data
                DispatchQueue.main.async {
                    self.mainCollectionView.reloadSections(IndexSet.init(integer: 0))
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SectionName.Banner.rawValue:
            return 1
        case SectionName.News.rawValue:
            return 1
        case SectionName.Grid.rawValue:
            return gridTitle.count
        case SectionName.Language.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SectionName.Banner.rawValue:
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.bannerCell, for: indexPath) as! BannerCollectionViewCell
            bannerCell.bannerImageCollectionView.delegate = bannerCell
            bannerCell.bannerImageCollectionView.dataSource = bannerCell
            bannerCell.bannerData = self.bannerData
            return bannerCell
        case SectionName.News.rawValue:
            let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.newsCell, for: indexPath) as! NewsCollectionViewCell
            if let news = firstNews {
                newsCell.updateUI(news: news)
            }
            return newsCell
        case SectionName.Grid.rawValue:
            let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.gridCell, for: indexPath) as! GridCollectionViewCell
            switch language {
            case Language.chinese.rawValue:
                gridCell.updateUI(imageName: gridImage[indexPath.row], title: gridTitle[indexPath.row])
            case Language.english.rawValue:
                gridCell.updateUI(imageName: gridImage[indexPath.row], title: gridImage[indexPath.row])
            default:
                break
            }
            return gridCell
        case SectionName.Language.rawValue:
            let language = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.languageCell, for: indexPath) as! LanguageCollectionViewCell
            language.chineseButton.addTarget(self, action: #selector(selectedLanguage(sender:)), for: .touchUpInside)
            language.englishButton.addTarget(self, action: #selector(selectedLanguage(sender:)), for: .touchUpInside)
            return language
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewCellKeyManager.collectionViewHeader, for: indexPath) as! MopconHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case SectionName.Banner.rawValue:
            return CGSize(width: self.view.frame.width, height: self.view.frame.height * (127/667))
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.item) {
        case (SectionName.News.rawValue,0):
            performSegue(withIdentifier: SegueIDManager.performNews, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.Agenda.rawValue):
            performSegue(withIdentifier: SegueIDManager.performAgenda, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.MySchedule.rawValue):
            performSegue(withIdentifier: SegueIDManager.performMySchedule, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.Communication.rawValue):
            performSegue(withIdentifier: SegueIDManager.performCommunication, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.Mission.rawValue):
            if let missionViewController = UIStoryboard(name: "Missions", bundle: nil).instantiateViewController(withIdentifier: "MissionsNavigationViewController") as? UINavigationController {
                self.present(missionViewController, animated: true, completion: nil)
            }
        case (SectionName.Grid.rawValue,GridSectionName.Sponsor.rawValue):
            performSegue(withIdentifier: SegueIDManager.performSponsors, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.Speaker.rawValue):
            performSegue(withIdentifier: SegueIDManager.performSpeaker, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.Group.rawValue):
            performSegue(withIdentifier: SegueIDManager.performCommunity, sender: nil)
        case (SectionName.Grid.rawValue,GridSectionName.News.rawValue):
            performSegue(withIdentifier: SegueIDManager.performNews, sender: nil)
        default:
            print("")
        }
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == SectionName.Banner.rawValue {
            return UIEdgeInsets.init(top: self.view.frame.height * (8/667), left: 0, bottom: self.view.frame.height * (8/667), right: 0)
        }
        
        return UIEdgeInsets.init(top: self.view.frame.height * (8/667), left: self.view.frame.width * (20/375), bottom: self.view.frame.height * (8/667), right: self.view.frame.width * (20/375))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.height * (16/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * (8/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case SectionName.Banner.rawValue:
            return CGSize(width: self.view.frame.width * 375/375, height: self.view.frame.height * (168/667))
        case SectionName.News.rawValue:
            return CGSize(width: self.view.frame.width * 336/375, height: self.view.frame.height * (72/667))
        case SectionName.Language.rawValue:
            return CGSize(width: self.view.frame.width * 336/375, height: 36)
        default:
            return CGSize(width: self.view.frame.width * 160/375, height: self.view.frame.width * 160/375)
        }
    }
}
