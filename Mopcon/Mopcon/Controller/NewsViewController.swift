//
//  NewsViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var news = [News.Payload]()
    let spinner = LoadingTool.setActivityindicator()
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.separatorStyle = .none
        
        getNews()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "News"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNews() {
        
        spinner.startAnimating()
        spinner.center = view.center
        self.view.addSubview(spinner)
        
        NewsAPI.getAPI(url: MopconAPI.shared.news) { (news, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.spinner.removeFromSuperview()
                return
            }
            
            if let news = news {
                self.news = news
                
                DispatchQueue.main.async {
                    self.spinner.removeFromSuperview()
                    self.newsTableView.reloadData()
                }
            }
        }
    }
    
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCellIDManager.newsCell, for: indexPath) as! NewsTableViewCell
        newsCell.index = indexPath
        newsCell.news = news[indexPath.row]
//        newsCell.delegate = self
        newsCell.updateUI(news: news[indexPath.row])
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
}

extension NewsViewController: ButtonDidTappedDelegate{
    func messageConnectionButtonDidTapped(index: IndexPath) {
        print("按下\(index.row)")
    }
    
    
}
