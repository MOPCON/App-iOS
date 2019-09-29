//
//  NewsViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class NewsViewController: MPBaseViewController {
    
    var newsList: [News] = []
    
    let spinner = LoadingTool.setActivityindicator()
    
    let refreshControll = UIRefreshControl()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControll.addTarget(self, action: #selector(fetchNews), for: .valueChanged)
        
        newsTableView.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        
        newsTableView.delegate = self
        
        newsTableView.dataSource = self
        
        newsTableView.separatorStyle = .none
        
        newsTableView.addSubview(refreshControll)
        
        fetchNews()
    }
    
    @objc func fetchNews() {
        
        if !refreshControll.isRefreshing {
            
            spinner.startAnimating()
            
            spinner.center = view.center
            
            self.view.addSubview(spinner)
        }
        
        NewsProvider.fetchNews(completion: { [weak self] result in
            
            switch result {
                
            case .success(let newsList):
                
                self?.newsList = newsList
                
            case .failure(let error):
                
                print(error)
            }
            
            self?.throwToMainThreadAsync {

                self?.refreshControll.endRefreshing()

                self?.spinner.removeFromSuperview()

                self?.newsTableView.reloadData()
            }
        })
    }
}
    
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsCell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        ) as! NewsTableViewCell

        newsCell.updateUI(news: newsList[indexPath.row])
        
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        openURL(newsList[indexPath.row].link)
    }
}
