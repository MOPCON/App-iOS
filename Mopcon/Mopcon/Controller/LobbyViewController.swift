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

class LobbyViewController: MPBaseViewController {

    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var chineseButton: UIButton!
    
    @IBOutlet weak var englishButton: UIButton!
    
    private var language = CurrentLanguage.getLanguage()
    
    private var bannerDatas: [Carousel.Payload] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        updateUI()
        
        getNews()
        
        getBanner()
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
        
        mainCollectionView.delegate = self
        
        mainCollectionView.dataSource = self
    }
    
    private func getBanner() {
        CarouselAPI.getAPI(url: MopconAPI.shared.carousel) { [weak self] (bannerData, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let data = bannerData{
                
                self?.bannerDatas = data
                
                let count: CGFloat = CGFloat(data.count)
                
                let screenWidth = UIScreen.main.bounds.width
                
                let contentWidth: CGFloat = screenWidth * (320 / 375)
                
                let contentTotalWidth = count * contentWidth
                
                let spacing = (count - 1) * screenWidth * (16 / 375)
                
                let width = contentTotalWidth + spacing
                
                DispatchQueue.main.async {
                    
                    let contentHeight: CGFloat = self?.bannerScrollView.frame.height ?? 85
                    
                    self?.containerView.frame = CGRect(origin: .zero, size: CGSize(width: width, height: contentHeight))
                    
                    self?.bannerScrollView.contentSize = self?.containerView.frame.size ?? .zero
                    
                    for (index, element) in data.enumerated() {
                        
                        let xPoint: CGFloat = CGFloat(index) * (contentWidth + spacing)
                        
                        self?.addImageView(with: xPoint, width: contentWidth, height: contentHeight, source: element.banner, tag: index)
                    }
                
                }
            }
        }
    }
    
    private func updateUI() {
        bannerScrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
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
    
    private func addImageView(with xStart: CGFloat, width: CGFloat, height: CGFloat, source: String, tag: Int) {
        let carouselImageView = UIImageView()
        
        carouselImageView.frame = CGRect(x: xStart, y: 0, width: width, height: height)
        
        carouselImageView.tag = tag
        
        carouselImageView.kf.setImage(with: URL(string: source))
        
        carouselImageView.contentMode = .scaleAspectFill
        
        carouselImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.bannerTapAction(_:)))
        
        carouselImageView.addGestureRecognizer(tapGesture)
        
        self.containerView.addSubview(carouselImageView)
    }
    
    @objc func bannerTapAction(_ gesture: UITapGestureRecognizer) {
        let imageView = gesture.view as? UIImageView
        
        let bannerData = bannerDatas[imageView?.tag ?? 0]
        
        if let url = URL(string: bannerData.link) {
            
            UIApplication.shared.open(url)
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
        
        tabBarController?.selectedIndex = 3
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
