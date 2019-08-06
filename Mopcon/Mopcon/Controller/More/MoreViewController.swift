//
//  MoreViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/6.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

private enum TabCategory: String {
    
    case communication = "Communication"
    
    case speaker = "Speaker"
    
    case sponsor = "Sponsor"
    
    case group = "Group"
    
    func storyboard() -> UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateInitialViewController() -> UIViewController {
        
        guard let vc = storyboard().instantiateInitialViewController() else {
            
            return UIViewController()
        }
        
        return vc
    }
    
    func image() -> UIImage? {
        
        switch self {
            
        case .communication: return UIImage.asset(.communication)
            
        case .speaker: return UIImage.asset(.speaker)
            
        case .sponsor: return UIImage.asset(.sponsor)
            
        case .group: return UIImage.asset(.group)
            
        }
    }
    
    func title() -> String {
        
        switch self {
            
        case .communication: return "交流場次"
            
        case .speaker: return "講者介紹"
            
        case .sponsor: return "贊助廠商"
            
        case .group: return "社群"
            
        }
    }
}

class MoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.dataSource = self
            
            tableView.delegate = self
        }
    }
    
    private let datas: [TabCategory] = [.communication, .speaker, .sponsor, .group]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.identifier, for: indexPath)
        
        guard let moreCell = cell as? MoreTableViewCell else { return cell }
        
        moreCell.layoutCell(
            image: datas[indexPath.row].image(),
            name: datas[indexPath.row].title()
        )
        
        return cell
    }
}

extension MoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = datas[indexPath.row].instantiateInitialViewController()
        
        show(vc, sender: nil)
    }
}
