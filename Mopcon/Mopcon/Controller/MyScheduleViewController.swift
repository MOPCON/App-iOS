//
//  MyScheduleViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/7.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController {
    
    var key = UserDefaultsKeys.dayOneSchedule
    var mySchedule = [Schedule.Payload.Agenda.Item.AgendaContent]() {
        didSet {
            mySchedule.sort { ( a, b) -> Bool in
                if let firstID = Int(a.schedule_id!), let secondID = Int(b.schedule_id!) {
                    if firstID < secondID {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
    }
    
    @IBOutlet weak var myScheduleTableView: UITableView!
    @IBOutlet weak var dayOneButton: CustomSelectedButton!
    @IBOutlet weak var dayTwoButton: CustomSelectedButton!
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseDayOneAction(_ sender: Any) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayOneButton, notSelectedButton: dayTwoButton)
        key = UserDefaultsKeys.dayOneSchedule
        mySchedule = MySchedules.get(forKey: key)
        myScheduleTableView.reloadData()
    }
    
    @IBAction func chooseDayTwoAction(_ sender: Any) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayTwoButton, notSelectedButton: dayOneButton)
        key = UserDefaultsKeys.dayTwoSchedule
        mySchedule = MySchedules.get(forKey: key)
        myScheduleTableView.reloadData()
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
        
        mySchedule = MySchedules.get(forKey: key)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Schedule"
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
        conferenceCell.delegate = self
        conferenceCell.indexPath = indexPath
        return conferenceCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
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

extension MyScheduleViewController: DeleteMySchedule {
    
    func deleteSchedule(indexPath: IndexPath) {
        let removeSchedule = mySchedule[indexPath.section]
        MySchedules.remove(agenda: removeSchedule, forKey: key)
        mySchedule = MySchedules.get(forKey: key)
        myScheduleTableView.reloadData()
        
    }
    
}
