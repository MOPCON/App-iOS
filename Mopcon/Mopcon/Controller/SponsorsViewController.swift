//
//  SponsorsViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

enum SponsorSection: Int {
    case tony_stark
    case bruce_wayne
    case geek
    case developer
    case educationSponsorship
    case specialThanks
    case co_organiser
}

class SponsorsViewController: UIViewController {
   
    var selectedSponsor: Sponsor.Payload?
    var sponsors = [[Sponsor.Payload]]()
    let spinner = LoadingTool.setActivityindicator()
    
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
        
        getSponsors()
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
    
    func getSponsors() {
        
        spinner.startAnimating()
        spinner.center = view.center
        self.view.addSubview(spinner)
        
        SponsorAPI.getAPI(url: MopconAPI.shared.sponsor) { (payload, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                self.spinner.removeFromSuperview()
                return
            }
            
            if let payload = payload {
                var tonyStark = [Sponsor.Payload]()
                var bruceWayne = [Sponsor.Payload]()
                var geek = [Sponsor.Payload]()
                var developer = [Sponsor.Payload]()
                var specialThanks = [Sponsor.Payload]()
                var educationSponsorship = [Sponsor.Payload]()
                var co_organisers = [Sponsor.Payload]()
                
                for sponsor in payload {
                    switch sponsor.type {
                    case "Tony Stark":
                        tonyStark.append(sponsor)
                    case "Bruce Wayne":
                        bruceWayne.append(sponsor)
                    case "Geek":
                        geek.append(sponsor)
                    case "Developer":
                        developer.append(sponsor)
                    case "教育贊助":
                        educationSponsorship.append(sponsor)
                    case "協辦單位":
                        co_organisers.append(sponsor)
                    default:
                        specialThanks.append(sponsor)
                    }
                }
                
                self.sponsors.append(tonyStark)
                self.sponsors.append(bruceWayne)
                self.sponsors.append(geek)
                self.sponsors.append(developer)
                self.sponsors.append(educationSponsorship)
                self.sponsors.append(specialThanks)
                self.sponsors.append(co_organisers)
                
                DispatchQueue.main.async {
                    self.sponsorsCollectionView.reloadData()
                    self.spinner.removeFromSuperview()
                }
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
        case SponsorSection.tony_stark.rawValue:
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
        case SponsorSection.tony_stark.rawValue:
            title = "ＴＯＮＹ ＳＴＡＲＫ"
        case SponsorSection.bruce_wayne.rawValue:
            title = "ＢＲＵＣＥ ＷＡＹＮＥ"
        case SponsorSection.geek.rawValue:
            title = "ＧＥＥＫ"
        case SponsorSection.developer.rawValue:
            title = "ＤＥＶＥＬＯＰＥＲ"
        case SponsorSection.educationSponsorship.rawValue:
            title = "教育贊助"
        case SponsorSection.specialThanks.rawValue:
            title = "特別感謝"
        case SponsorSection.co_organiser.rawValue:
            title = "協辦單位"
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
        case SponsorSection.tony_stark.rawValue:
            return CGSize(width: self.view.frame.width * (343/375), height: self.view.frame.width * (164/375))
        default:
            return CGSize(width: self.view.frame.width * (164/375), height: self.view.frame.width * (164/375))
        }
    }
}
