//
//  MPBaseSessionViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/9/20.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

let ConferenceTableViewCellBasisHeight = 226.0

class MPBaseSessionViewController: MPBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        
        setupTableViewCell()
    }
    
    private func setupTableViewCell() {
        
        let conferenceTableViewCell = UINib(nibName: ConferenceTableViewCell.identifier, bundle: nil)
        
        tableView.register(
            conferenceTableViewCell,
            forCellReuseIdentifier: ConferenceTableViewCell.identifier
        )
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    //MARK: - UITableViewDelegate
}
