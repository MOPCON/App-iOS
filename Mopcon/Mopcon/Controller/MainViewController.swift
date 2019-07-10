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

class MainViewController: UIViewController {

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
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    
        updateUI()
        getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
