//
//  VolunteerViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController {
    
    var volunteers = [Volunteer.Payload]()
    
    @IBOutlet weak var volunteerTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        volunteerTableView.separatorStyle = .none
        volunteerTableView.delegate = self
        volunteerTableView.dataSource = self
        volunteerTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData() {
        if let url = URL(string: "https://dev.mopcon.org/2018/api/volunteer") {
            VolunteerAPI.getAPI(url: url) { (volunteers, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                if let volunteers = volunteers {
                    print("get Data")
                    self.volunteers = volunteers
                    
                    DispatchQueue.main.async {
                        self.volunteerTableView.reloadData()
                    }
                }
                
                
            }
        }
    }
    
}

extension VolunteerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let volunteerCell = tableView.dequeueReusableCell(withIdentifier: VolunteerTableCellIDManager.volunteerTableViewCell, for: indexPath) as! VolunteerTableViewCell
        
        volunteerCell.updateUI(volunteer: volunteers[indexPath.row])
        return volunteerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
