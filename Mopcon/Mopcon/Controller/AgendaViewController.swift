//
//  AgendaViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController {
    
    @IBOutlet weak var dayOneButton: UIButton!
    @IBOutlet weak var dayTwoButton: UIButton!
    @IBOutlet weak var goToCommunicationVCButton: CustomCornerButton!
    @IBOutlet weak var agendaTableView: UITableView!
    
    var selectedSchedule = [Schedule.Payload.Agenda.Item]()
    var selectedAgenda:Schedule.Payload.Agenda.Item.AgendaContent?
    
    var mySchedule = MySchedules.get()
    var schedule_day1 = [Schedule.Payload.Agenda.Item]()
    var schedule_day2 = [Schedule.Payload.Agenda.Item]()
    
    
    @IBAction func chooseDayOneAction(_ sender: Any) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayOneButton as! CustomSelectedButton, notSelectedButton: dayTwoButton as! CustomSelectedButton)
        selectedSchedule = schedule_day1
        agendaTableView.reloadData()
    }
    
    @IBAction func chooseDayTwoAction(_ sender: Any) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayTwoButton as! CustomSelectedButton, notSelectedButton: dayOneButton as! CustomSelectedButton)
        selectedSchedule = schedule_day2
        agendaTableView.reloadData()
    }
    
    
    @IBAction func goToCommunicationVC(_ sender: UIButton) {
        let communicationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardIDManager.communicationVC) as! CommunicationViewController
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.pushViewController(communicationVC, animated: true)
    }
    
   
    
    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        agendaTableView.separatorStyle = .none
        //因為現在tableView就是group所以要把footer的高度拿掉，要不然會留一塊
        agendaTableView.sectionFooterHeight = 0
        
        guard let url = URL(string: "https://dev.mopcon.org/2018/api/schedule") else {
            print("Invalid URL.")
            return
        }
        
        ScheduleAPI.getAPI(url: url) { (payload, error) in
            if let payload = payload {
                self.schedule_day1 = payload.agenda[0].items
                self.schedule_day2 = payload.agenda[1].items
                self.selectedSchedule = self.schedule_day1
                DispatchQueue.main.async {
                    self.agendaTableView.reloadData()
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDManager.performConferenceDetail {
            if let vc = segue.destination as? ConferenceDetailViewController {
                vc.agenda = self.selectedAgenda
            }
        }
    }
    
}


// MARK : Tableview Datasource & Tableview Delegate
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedSchedule.count
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSchedule[section].agendas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case indexPath.section:
            let conferenceCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.conferenceCell, for: indexPath) as! ConferenceTableViewCell
            let agenda = selectedSchedule[indexPath.section].agendas[indexPath.row]
            checkMySchedule(agenda: agenda, sender: conferenceCell.addToMyScheduleButton)
            conferenceCell.updateUI(agenda: agenda)
            conferenceCell.delegate = self
            conferenceCell.index = indexPath
            return conferenceCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAgenda = selectedSchedule[indexPath.section].agendas[indexPath.row]
        performSegue(withIdentifier: SegueIDManager.performConferenceDetail, sender: nil)
    }
    
    func checkMySchedule(agenda:Schedule.Payload.Agenda.Item.AgendaContent ,sender: UIButton) {
        for schedule in mySchedule {
            if schedule.schedule_topic == agenda.schedule_topic {
                sender.setImage(#imageLiteral(resourceName: "buttonStarChecked"), for: .normal)
                return
            }
        }
        sender.setImage(#imageLiteral(resourceName: "buttonStarNormal"), for: .normal)
    }
}

extension AgendaViewController: WhichCellButtonDidTapped {
    
    func whichCellButtonDidTapped(sender: UIButton, index: IndexPath) {
        
        let agenda = selectedSchedule[index.section].agendas[index.row]
        
        if sender.image(for: .normal) == #imageLiteral(resourceName: "buttonStarChecked") {
            print("新增行程")
            MySchedules.add(agenda: agenda)
        } else if sender.image(for: .normal) == #imageLiteral(resourceName: "buttonStarNormal"){
            print("刪除行程")
            MySchedules.remove(agenda: agenda)
        }
        
        self.mySchedule = MySchedules.get()
        self.agendaTableView.reloadRows(at: [index], with: .automatic)
    }
    
}
