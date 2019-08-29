//
//  MissionListViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class FieldGameViewController: MPBaseViewController {

    @IBOutlet weak var headerView: FieldGameHeaderView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        
        headerView.frame.size.height = 170
        
        tableView.tableHeaderView = headerView
        
        let nib = UINib(
            nibName: GameStageCell.identifier,
            bundle: nil
        )
        
        tableView.register(
            nib,
            forCellReuseIdentifier: GameStageCell.identifier
        )
        
        let completeNib = UINib(
            nibName: CompleteCell.identifier,
            bundle: nil
        )
        
        tableView.register(
            completeNib,
            forCellReuseIdentifier: CompleteCell.identifier
        )
    }
}

extension FieldGameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GameStageCell.identifier,
            for: indexPath)
        
        guard let stageCell = cell as? GameStageCell else { return cell }
        
        stageCell.updateUI(isComplete: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {

        return 112
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = tableView.dequeueReusableCell(
            withIdentifier: CompleteCell.identifier
        )
        
        return footer
    }
}

extension FieldGameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            guard let stageCell = cell as? GameStageCell else { return }
            
            stageCell.startTimer()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            guard let stageCell = cell as? GameStageCell else { return }
            
            stageCell.stopTimer()
        }
    }
}
