//
//  VolunteerViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController {
    
    
    @IBOutlet weak var volunteerTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        volunteerTableView.separatorStyle = .none
        volunteerTableView.delegate = self
        volunteerTableView.dataSource = self
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
extension VolunteerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let volunteerCell = tableView.dequeueReusableCell(withIdentifier: VolunteerTableCellIDManager.volunteerTableViewCell, for: indexPath) as! VolunteerTableViewCell
        return volunteerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
}
