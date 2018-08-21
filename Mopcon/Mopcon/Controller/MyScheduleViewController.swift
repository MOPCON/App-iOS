//
//  MyScheduleViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController {
    
    var mySchedule = [Schedule.Payload.Agenda.Item.AgendaContent]()
    
    @IBOutlet weak var myScheduleTableView: UITableView!
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScheduleTableView.delegate = self
        myScheduleTableView.dataSource = self
        myScheduleTableView.separatorStyle = .none
        myScheduleTableView.sectionFooterHeight = 0
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        mySchedule = MySchedules.get()
        for i in mySchedule {
            print(i.name)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySchedule.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conferenceCell = tableView.dequeueReusableCell(withIdentifier: MyScheduleTableViewCellID.conferenceCell, for: indexPath) as! MyScheduleConferenceTableViewCell
        conferenceCell.update(mySchedule: mySchedule[indexPath.section])
        return conferenceCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let timeLabel = UILabel(frame: CGRect(x: view.center.x + 116, y: view.center.y + 5.5, width: 116, height: 22))
        timeLabel.font = UIFont(name: "PingFangTC-Medium", size: 16)
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        view.backgroundColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.5)
        view.addSubview(timeLabel)
        
        timeLabel.text = mySchedule[section].duration
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    
}
