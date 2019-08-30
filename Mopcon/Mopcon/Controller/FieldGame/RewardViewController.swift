//
//  RewardViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/30.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class RewardViewController: MPBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        
        let xib = UINib(nibName: PresentCell.identifier, bundle: nil)
        
        tableView.register(xib, forCellReuseIdentifier: PresentCell.identifier)
    }
}

extension RewardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PresentCell.identifier, for: indexPath)
        
        return cell
    }
}

extension RewardViewController: UITableViewDelegate {
    
    
}
