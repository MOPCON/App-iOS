//
//  CommunicationViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunicationViewController: UIViewController {
   
    var selectedSchedule = [Schedule_unconf.Payload.Item]()
    
    var schedule_day1 = [Schedule_unconf.Payload.Item]()
    var schedule_day2 = [Schedule_unconf.Payload.Item]()

    @IBOutlet weak var dayOneButton: CustomSelectedButton!
    @IBOutlet weak var dayTwoButton: CustomSelectedButton!
    @IBOutlet weak var communicationTableView: UITableView!
    
    @IBOutlet weak var goToMainAgendaVCButton: CustomCornerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        communicationTableView.separatorStyle = .none
        communicationTableView.delegate = self
        communicationTableView.dataSource = self
        //因為現在tableView就是group所以要把footer的高度拿掉，要不然會留一塊
        communicationTableView.sectionFooterHeight = 0
        
        Schedule_unconfAPI.getAPI(url: MopconAPI.shared.schedule_unconf) { (payload, error) in
            if let payload = payload {
                self.schedule_day1 = payload[0].items
                self.schedule_day2 = payload[1].items
                self.selectedSchedule = self.schedule_day1
                
                DispatchQueue.main.async {
                    self.communicationTableView.reloadData()
                }
                
            }
        }
    }
    
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToMainAgenda(_ sender: UIButton) {
            let agendaVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardIDManager.agendaVC) as! AgendaViewController
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
            self.navigationController?.pushViewController(agendaVC, animated: true)
        
    }
    
    
    @IBAction func tappedDayOneButtonAction(_ sender: CustomSelectedButton) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayOneButton, notSelectedButton: dayTwoButton)
        selectedSchedule = schedule_day1
        communicationTableView.reloadData()
    }
    
    @IBAction func tappedDayTwoButtonAction(_ sender: CustomSelectedButton) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayTwoButton, notSelectedButton: dayOneButton)
        selectedSchedule = schedule_day2
        communicationTableView.reloadData()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension CommunicationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedSchedule.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let schedule = selectedSchedule[indexPath.section]
        
        switch schedule.type {
        case "others":
            let communicationBreakCell = tableView.dequeueReusableCell(withIdentifier: CommunicationTableViewCellID.communicationBreakCell, for: indexPath) as! CommunicationBreakTableViewCell
            communicationBreakCell.updateUI(schedule: schedule)
            return communicationBreakCell
        default:
            let communicationConferenceCell = tableView.dequeueReusableCell(withIdentifier: CommunicationTableViewCellID.communicationConferenceCell, for: indexPath) as! CommunicationConferenceTableViewCell
            communicationConferenceCell.updateUI(schedule: schedule)
            return communicationConferenceCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let schedule = selectedSchedule[indexPath.section]
        
        switch schedule.type {
        case "others":
            return 68
        default:
            return 141
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
        timeLabel.text = selectedSchedule[section].duration
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
}
