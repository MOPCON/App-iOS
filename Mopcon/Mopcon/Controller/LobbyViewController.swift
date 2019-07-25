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

class LobbyViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var chineseButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    private var language = CurrentLanguage.getLanguage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        updateUI()
        getNews()
    }
    
    private func getNews() {
        NewsAPI.getAPI(url: MopconAPI.shared.news) { [weak self] (news, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let news = news, !news.isEmpty{
                DispatchQueue.main.async {
                    self?.descriptionLabel.text = news.first?.title
                }
            }
        }
    }

    private func setupCollectionView() {
    
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
        mainCollectionView.contentOffset = CGPoint(x: -20, y: 0)
        
        let nib = UINib(
            nibName: String(describing: LobbyCollectionViewCell.self),
            bundle: nil
        )
        mainCollectionView.register(
            nib,
            forCellWithReuseIdentifier: String(describing: LobbyCollectionViewCell.self)
        )
        
        let layoutObject = mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        layoutObject?.scrollDirection = .horizontal
        layoutObject?.itemSize = CGSize(width: 335.0, height: 300.0)
        layoutObject?.minimumLineSpacing = 12.0
        
    }
    
    private func updateUI() {
        switch language {
        case Language.chinese.rawValue:
            newsTitleLabel.text = "最新消息"
            favoriteTitleLabel.text = "你最想聽的演講要開始了"
            moreButton.setTitle("查看更多", for: .normal)
            chineseButton.isSelected = true
            englishButton.isSelected = false
            
        case Language.english.rawValue:
            newsTitleLabel.text = "News"
            favoriteTitleLabel.text = "Favorite"
            moreButton.setTitle("More", for: .normal)
            chineseButton.isSelected = false
            englishButton.isSelected = true
            
        default:
            break
        }
    }
    
    @IBAction func selectedLanguage(sender: UIButton) {
        switch sender.currentTitle {
        case "中文":
            UserDefaults.standard.set(Language.chinese.rawValue, forKey: "language")
            
        case "EN":
            UserDefaults.standard.set(Language.english.rawValue, forKey: "language")
            
        default:
            return
        }
        
        language = CurrentLanguage.getLanguage()
        updateUI()
    }
    
    @IBAction func moreNews(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIDManager.performNews, sender: nil)
    }
    
}

extension LobbyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: LobbyCollectionViewCell.self),
            for: indexPath
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width - 40
        
        let height = collectionView.frame.height - 45
        
        return CGSize(width: width, height: height)
    }
}
