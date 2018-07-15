//
//  MyScheduleViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController {
    
    
    @IBOutlet weak var myScheduleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScheduleTableView.delegate = self
        myScheduleTableView.dataSource = self
        myScheduleTableView.separatorStyle = .none
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 2, 4:
            let breakCell = tableView.dequeueReusableCell(withIdentifier: MyScheduleTableViewCellID.breakCell, for: indexPath)
            return breakCell
        case 1, 5:
            let noScheduleCell = tableView.dequeueReusableCell(withIdentifier: MyScheduleTableViewCellID.noScheduleCell, for: indexPath)
            return noScheduleCell
        default:
            let conferenceCell = tableView.dequeueReusableCell(withIdentifier: MyScheduleTableViewCellID.conferenceCell, for: indexPath)
            return conferenceCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 2, 4:
            return 68
        case 1, 5:
            return 120
        default:
            return 172
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let timeLabel = UILabel(frame: CGRect(x: view.center.x + 116, y: view.center.y + 5.5, width: 116, height: 22))
        timeLabel.font = UIFont(name: "PingFangTC-Medium", size: 16)
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        view.backgroundColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.5)
        view.addSubview(timeLabel)
        timeLabel.text = "09:00 - 09:15"
        return view
        
    }
    
    
}
