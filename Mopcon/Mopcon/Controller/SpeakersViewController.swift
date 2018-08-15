//
//  SpeakersViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController {
    
    var selectedSpeaker:Speaker.Payload?
    var speakers = [Speaker.Payload]()
    
    @IBOutlet weak var speakersTableView: UITableView!

    
    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationBar設定透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        speakersTableView.delegate = self
        speakersTableView.dataSource = self
        speakersTableView.separatorStyle = .none
        
        guard let url = URL(string: "https://dev.mopcon.org/2018/api/speaker") else {
            print("Invalid URL.")
            return
        }
        
        SpeakerAPI.getAPI(url: url) { (payload, error) in
            if let payload = payload {
                self.speakers = payload
                DispatchQueue.main.async {
                    self.speakersTableView.reloadData()
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
        if segue.identifier == SegueIDManager.performSpeakerDetail {
            if let vc = segue.destination as? SpeakerDetailViewController {
                vc.speaker = selectedSpeaker
            }
        }
    }


}

extension SpeakersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let speakerCell = tableView.dequeueReusableCell(withIdentifier: SpeakersTableViewCellIDManager.speakerCell, for: indexPath) as! SpeakerTableViewCell
        speakerCell.updateUI(speaker: speakers[indexPath.row])
        return speakerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //到時候要傳講者資料過去 sender再設定
        self.selectedSpeaker = speakers[indexPath.row]
        performSegue(withIdentifier: SegueIDManager.performSpeakerDetail, sender: nil)
    }
    
}
