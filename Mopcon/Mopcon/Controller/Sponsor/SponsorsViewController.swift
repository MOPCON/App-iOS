//
//  SponsorsViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SponsorsViewController: MPBaseViewController {
    
    private struct Segue {
        
        static let detail = "SponsorSegue"
    }
    
    var sponsorList: [SponsorList] = [] {
        
        didSet {
            
            throwToMainThreadAsync { [weak self] in
                
                self?.sponsorsCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var sponsorsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSponsors()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.detail {
        
            if let vc = segue.destination as? SponsorDetailViewController,
               let sponsor = sender as? Sponsor {
            
                vc.sponsor = sponsor
            }
        }
    }
    
    func getSponsors() {
        
        SponsorProvider.fetchSponsor(completion: { [weak self] result in
            
            switch result{
                
            case .success(let sponsorList):
                
                self?.sponsorList = sponsorList
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}
extension SponsorsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return sponsorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sponsorList[section].data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sponsor = sponsorList[indexPath.section].data[indexPath.row]

        let smallImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SponsorCollectionViewIDManager.sponsorCollectionCell,
            for: indexPath
        ) as! SponsorSmallCollectionViewCell

        smallImageCell.updateUI(sponsor: sponsor)

        return smallImageCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SponsorCollectionViewIDManager.sponsorHeader,
            for: indexPath
        ) as! SponsorHeaderView

        headerView.updateUI(section: indexPath.section, title: sponsorList[indexPath.section].name)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(
            withIdentifier: Segue.detail,
            sender: sponsorList[indexPath.section].data[indexPath.row]
        )
    }
}

extension SponsorsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(
            top: 24,
            left: self.view.frame.width * (16 / 375),
            bottom: self.view.frame.width * (16 / 375),
            right: self.view.frame.width * (16 / 375)
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(
            width: self.view.frame.width * (164 / 375),
            height: 115
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
        ) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
}
