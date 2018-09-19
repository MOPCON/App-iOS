//
//  SponsorsViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum SponsorType: String {
    case tony_stark = "Tony Stark"
    case bruce_wayne = "Bruce Wayne"
    case geek = "Geek"
    case developer = "Developer"
    case specialThanks = "特別感謝"
}

class SponsorsViewController: UIViewController {
   
    var selectedSponsor: Sponsor.Payload?
    var sponsors = [[Sponsor.Payload]]()
    
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
        
        SponsorAPI.getAPI(url: MopconAPI.shared.sponsor) { (payload, error) in
            if let payload = payload {
                
                var tonyStark = [Sponsor.Payload]()
                var bruceWayne = [Sponsor.Payload]()
                var geek = [Sponsor.Payload]()
                var developer = [Sponsor.Payload]()
                var specialThanks = [Sponsor.Payload]()
                
                for sponsor in payload {
                    switch sponsor.type {
                    case SponsorType.tony_stark.rawValue:
                        tonyStark.append(sponsor)
                    case SponsorType.bruce_wayne.rawValue:
                        bruceWayne.append(sponsor)
                    case SponsorType.geek.rawValue:
                        geek.append(sponsor)
                    case SponsorType.developer.rawValue:
                        developer.append(sponsor)
                    default:
                        specialThanks.append(sponsor)
                    }
                }
                
                self.sponsors.append(tonyStark)
                self.sponsors.append(bruceWayne)
                self.sponsors.append(geek)
                self.sponsors.append(developer)
                self.sponsors.append(specialThanks)
                
                DispatchQueue.main.async {
                    self.sponsorsCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Sponsor"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDManager.performSponsorDetail{
            if let vc = segue.destination as? SponsorDetailViewController {
                vc.sponsor = self.selectedSponsor
            }
        }
    }
}
extension SponsorsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sponsors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sponsors[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sponsor = sponsors[indexPath.section][indexPath.row]
        
        switch indexPath.section {
        case SponsorType.tony_stark.hashValue:
            let bigImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsorCollectionViewIDManager.sponsorBigCollectionView, for: indexPath) as! SponsorBigCollectionViewCell
            bigImageCell.updateUI(sponsor: sponsor)
            return bigImageCell
        default:
            let smallImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: SponsorCollectionViewIDManager.sponsorCollectionCell, for: indexPath) as! SponsorSmallCollectionViewCell
            smallImageCell.updateUI(sponsor: sponsor)
            return smallImageCell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SponsorCollectionViewIDManager.sponsorHeader, for: indexPath) as! SponsorHeaderView
        
        var title = ""
        
        switch indexPath.section {
        case SponsorType.tony_stark.hashValue:
            title = SponsorType.tony_stark.rawValue
        case SponsorType.bruce_wayne.hashValue:
            title = SponsorType.bruce_wayne.rawValue
        case SponsorType.geek.hashValue:
            title = SponsorType.geek.rawValue
        case SponsorType.developer.hashValue:
            title = SponsorType.developer.rawValue
        case SponsorType.specialThanks.hashValue:
            title = SponsorType.specialThanks.rawValue
        default:
            break
        }
        headerView.layoutIfNeeded()
        headerView.updateUI(title: title)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSponsor = sponsors[indexPath.section][indexPath.row]
        performSegue(withIdentifier: SegueIDManager.performSponsorDetail, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        if sponsors[section].isEmpty {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
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
        case SponsorType.tony_stark.hashValue:
            return CGSize(width: self.view.frame.width * (343/375), height: self.view.frame.width * (164/375))
        default:
            return CGSize(width: self.view.frame.width * (164/375), height: self.view.frame.width * (164/375))
        }
    }
}
