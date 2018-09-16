//
//  ViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/1.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum SectionName:Int {
    case Banner = 0
    case News
    case Grid
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
    
    
 
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //fake Data
    let gridImage = ["Agenda","Schedule","Communication","Mission","Sponsor","Speaker","Group","News"]
    let gridTitle = ["議程","我的行程","交流場次","任務","贊助廠商","講者","社群","最新消息"]

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundView = UIImageView(image: UIImage(named: "bgMainPage"))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SectionName.Banner.rawValue:
            return 1
        case SectionName.News.rawValue:
            return 1
        case SectionName.Grid.rawValue:
            return gridTitle.count
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
            return bannerCell
        case SectionName.News.rawValue:
            let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.newsCell, for: indexPath) as! NewsCollectionViewCell
            newsCell.updateUI()
            return newsCell
        case SectionName.Grid.rawValue:
            let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellKeyManager.gridCell, for: indexPath) as! GridCollectionViewCell
            gridCell.updateUI(imageName: self.gridImage[indexPath.item], title: self.gridTitle[indexPath.item])
            return gridCell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionViewCellKeyManager.collectionViewHeader, for: indexPath) as! MopconHeader
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
//            return UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        return UIEdgeInsetsMake(self.view.frame.height * (8/667), self.view.frame.width * (20/375), self.view.frame.height * (8/667), self.view.frame.width * (20/375))
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
            return CGSize(width: self.view.frame.width * 300/375, height: self.view.frame.height * (168/667))
        case SectionName.News.rawValue:
            return CGSize(width: self.view.frame.width * 336/375, height: self.view.frame.height * (72/667))
        default:
            return CGSize(width: self.view.frame.width * 160/375, height: self.view.frame.width * 160/375)
        }
    }
}
