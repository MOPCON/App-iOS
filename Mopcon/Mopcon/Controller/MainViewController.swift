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
            return CGSize(width: self.view.frame.width, height: 127)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.item) {
        case (SectionName.Grid.rawValue,GridSectionName.Agenda.rawValue):
            print("議程")
        case (SectionName.Grid.rawValue,GridSectionName.MySchedule.rawValue):
            print("我的行程")
        case (SectionName.Grid.rawValue,GridSectionName.Communication.rawValue):
            print("交流場次")
        case (SectionName.Grid.rawValue,GridSectionName.Mission.rawValue):
            print("任務")
        case (SectionName.Grid.rawValue,GridSectionName.Sponsor.rawValue):
            print("贊助廠商")
        case (SectionName.Grid.rawValue,GridSectionName.Speaker.rawValue):
            print("講者")
        case (SectionName.Grid.rawValue,GridSectionName.Group.rawValue):
            print("社群")
        case (SectionName.Grid.rawValue,GridSectionName.News.rawValue):
            performSegue(withIdentifier: SegueIDManager.performNews, sender: nil)
        default:
            print("")
        }
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case SectionName.Banner.rawValue:
            return CGSize(width: 300, height: 168)
        case SectionName.News.rawValue:
            return CGSize(width: 336, height: 72)
        default:
            return CGSize(width: 160, height: 160)
        }
    }
}
