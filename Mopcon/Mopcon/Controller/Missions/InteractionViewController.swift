//
//  InteractionViewController.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/9/4.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class InteractionViewController: UIViewController {

    @IBOutlet weak var interactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactionTableView.dataSource = self
        interactionTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Tableview datasource & delegate

extension InteractionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let companyCell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath)
            return companyCell
        case 1:
            let contentCell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)
            return contentCell
        case 2:
            let submitCell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath)
            return submitCell
        default:
            fatalError("Can't create Tableview Cell")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 180
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            return 150
        default:
            return 0
        }
    }
   
    
}
