//
//  SponsorsViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum SponsorSectionName:Int{
    case TONYSTARK = 0
    case BRUCEWAYNE
    case GEEK
}

class SponsorsViewController: UIViewController {

    let sectionTitle = ["TONY STARK", "BRUCE WAYNE", "GEEK"]
    let sectionOneImageArray = ["google"]
    let sectionTwoImageArray = ["webDuino","amazon","uber","fitw","walt","cluj"]
    let sectionThreeImageArray = ["ashton","upgrade","brave","mdamob","design","kitchen"]
    
    @IBOutlet weak var sponsorsCollectionView: UICollectionView!
    
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        sponsorsCollectionView.delegate = self
        sponsorsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SponsorsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SponsorSectionName.TONYSTARK.rawValue:
            return sectionOneImageArray.count
        case SponsorSectionName.BRUCEWAYNE.rawValue:
            return sectionTwoImageArray.count
        case SponsorSectionName.GEEK.rawValue:
            return sectionThreeImageArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case SponsorSectionName.TONYSTARK.rawValue:
            let bigImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsorCollectionViewIDManager.sponsorBigCollectionView, for: indexPath) as! SponsorBigCollectionViewCell
            bigImageCell.updateUI(imageName: sectionOneImageArray[indexPath.item])
            return bigImageCell
        case SponsorSectionName.BRUCEWAYNE.rawValue:
            let smallImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsorCollectionViewIDManager.sponsorCollectionCell, for: indexPath) as! SponsorSmallCollectionViewCell
            smallImageCell.updateUI(imageName: sectionTwoImageArray[indexPath.item])
            return smallImageCell
        case SponsorSectionName.GEEK.rawValue:
            let smallImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsorCollectionViewIDManager.sponsorCollectionCell, for: indexPath) as! SponsorSmallCollectionViewCell
            smallImageCell.updateUI(imageName: sectionThreeImageArray[indexPath.item])
            return smallImageCell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SponsorCollectionViewIDManager.sponsorHeader, for: indexPath) as! SponsorHeaderView
        headerView.updateUI(title: sectionTitle[indexPath.section])
        return headerView
    }
}

extension SponsorsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, self.view.frame.width * (16/375), self.view.frame.width * (16/375), self.view.frame.width * (16/375))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * (16/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.view.frame.width * (8/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case SponsorSectionName.TONYSTARK.rawValue:
            return CGSize(width: self.view.frame.width * (343/375), height: self.view.frame.width * (164/375))
        default:
            return CGSize(width: self.view.frame.width * (164/375), height: self.view.frame.width * (164/375))
        }
    }
}
