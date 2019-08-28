//
//  MissionListViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class FileGameViewController: MPBaseViewController {

    @IBOutlet weak var headerView: FieldGameHeaderView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        
        headerView.frame.size.height = 170
        
        tableView.tableHeaderView = headerView
        
        let nib = UINib(nibName: GameStageCell.identifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: GameStageCell.identifier)
    }
}

extension FileGameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GameStageCell.identifier, for: indexPath)
        
        guard let stageCell = cell as? GameStageCell else { return cell }
        
        stageCell.updateUI(isComplete: true)
        
        return cell
    }
}

extension FileGameViewController: UITableViewDelegate {
    
}
