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
    let refreshControll = UIRefreshControl()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: (UIColor.azure?.withAlphaComponent(0.2))!)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        refreshControll.addTarget(self, action: #selector(getNews), for: .valueChanged)
        
        newsTableView.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.separatorStyle = .none
        newsTableView.addSubview(refreshControll)
        
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
    
    @objc func getNews() {
        
        if !refreshControll.isRefreshing {
            spinner.startAnimating()
            spinner.center = view.center
            self.view.addSubview(spinner)
        }
        
        NewsAPI.getAPI(url: MopconAPI.shared.news) { [weak self] (news, error) in
            if error != nil {
                print(error!.localizedDescription)
                self?.spinner.removeFromSuperview()
                self?.refreshControll.endRefreshing()
                return
            }
            
            if let news = news {
                self?.news = news
                
                DispatchQueue.main.async {
                    self?.refreshControll.endRefreshing()
                    self?.spinner.removeFromSuperview()
                    self?.newsTableView.reloadData()
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
        newsCell.news = news[indexPath.row]
        newsCell.updateUI(news: news[indexPath.row])
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: news[indexPath.row].link) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
