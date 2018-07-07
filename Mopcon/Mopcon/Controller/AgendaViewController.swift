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
    
    
    var section1ModelArray = [AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false)]
    var section3ModelArray = [AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false),AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false),AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false)]
    var section5ModelArray = [AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false),AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false),AgendaModel(category: "CLOUD", title: "Innovate width New Technologies on Google", speaker: "田哲宇", location: "R1: 一廳", addedToMySchedule: false)]
    
    @IBAction func chooseDayOneAction(_ sender: UIButton) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayOneButton as! CustomSelectedButton, notSelectedButton: dayTwoButton as! CustomSelectedButton)
    }
    
    @IBAction func chooseDayTwoAction(_ sender: UIButton) {
        CommonFucntionHelper.changeButtonColor(beTappedButton: dayTwoButton as! CustomSelectedButton, notSelectedButton: dayOneButton as! CustomSelectedButton)
    }
    
    
    @IBAction func goToCommunicationVC(_ sender: UIButton) {
            let communicationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardIDManager.communicationVC) as! CommunicationViewController
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
            self.navigationController?.pushViewController(communicationVC, animated: true)
    }
    
    @IBOutlet weak var agendaTableView: UITableView!
    
    
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
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AgendaViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let timeLabel = UILabel(frame: CGRect(x: view.center.x + 116, y: view.center.y + 5.5, width: 116, height: 22))
        timeLabel.font = UIFont(name: "PingFangTC-Medium", size: 16)
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        view.backgroundColor = UIColor(red: 0, green: 208/255, blue: 203/255, alpha: 0.5)
        view.addSubview(timeLabel)
        switch section {
        case 0:
             timeLabel.text = "09:00 - 09:15"
        case 1:
            timeLabel.text = "09:15 - 10:00"
        case 2:
            timeLabel.text = "10:00 - 10:15"
        case 3:
            timeLabel.text = "10:15 - 11:00"
        default:
            timeLabel.text = "11:00 - 11:15"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return section1ModelArray.count
        case 2:
            return 1
        case 3:
            return section3ModelArray.count
        case 4:
            return 1
        case 5:
            return section5ModelArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 2, 4:
            let breakCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.breakCell, for: indexPath) as! BreakTableViewCell
            return breakCell
        case 1:
            let conferenceCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.conferenceCell, for: indexPath) as! ConferenceTableViewCell
            conferenceCell.updateUI(model: section1ModelArray[indexPath.row])
            conferenceCell.delegate = self
            conferenceCell.index = indexPath
            return conferenceCell
        case 3:
            let conferenceCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.conferenceCell, for: indexPath) as! ConferenceTableViewCell
            conferenceCell.updateUI(model: section3ModelArray[indexPath.row])
            conferenceCell.delegate = self
            conferenceCell.index = indexPath
            return conferenceCell
        case 5:
            let conferenceCell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCellID.conferenceCell, for: indexPath) as! ConferenceTableViewCell
            conferenceCell.updateUI(model: section5ModelArray[indexPath.row])
            conferenceCell.delegate = self
            conferenceCell.index = indexPath
            return conferenceCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch  indexPath.section {
        case 0,2,4:
            return 68
        default:
            return 174
        }
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch  indexPath.section {
//        case 0,2,4:
//            return 68
//        default:
//            return 174
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1,3,5:
            performSegue(withIdentifier: SegueIDManager.performConferenceDetail, sender: nil)
        default:
            break
        }
        
    }
}

extension AgendaViewController: WhichCellButtonDidTapped{
    func whichCellButtonDidTapped(index: IndexPath) {
//        print(index)
//        let chooseCell = agendaTableView.cellForRow(at: index) as! ConferenceTableViewCell
//        chooseCell.buttonDidTapped = !chooseCell.buttonDidTapped
        switch index.section {
        case 1:
            section1ModelArray[index.row].addedToMySchedule = !section1ModelArray[index.row].addedToMySchedule
//            agendaTableView.reloadRows(at: [index], with: .none)
        case 3:
            section3ModelArray[index.row].addedToMySchedule = !section3ModelArray[index.row].addedToMySchedule
//            agendaTableView.reloadRows(at: [index], with: .none)
        case 5:
            section5ModelArray[index.row].addedToMySchedule = !section5ModelArray[index.row].addedToMySchedule
//            agendaTableView.reloadRows(at: [index], with: .none)
        default:
            break
        }
        agendaTableView.reloadData()
    }
}
