//
//  SpeakersViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakersViewController: MPBaseViewController {
    
    override var hidesBottomBarWhenPushed: Bool {
        
        get {
            return true
        }
        
        set {
            
        }
    }
    
//    var tags: [SpeakerTag] = [.blockchain, .design, .ioT]
//
//    var selectedSpeaker:Speaker.Payload?
//
//    var speakers = [Speaker.Payload]()
    
    let spinner = LoadingTool.setActivityindicator()
    
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
        
        fetchSpeakers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Speaker"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDManager.performSpeakerDetail {
            if let vc = segue.destination as? SpeakerDetailViewController {
//                vc.speaker = selectedSpeaker
            }
        }
    }
    
    func fetchSpeakers() {
        
        SpeakerProvider.fetchSpeakers(completion: { result in
            
            switch result {
                
            case .success(let speakers):
                
                print(speakers)
                
            case .failure(let error):
                
                print(error)
            }
        })
        
    }


}

extension SpeakersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return speakers.count
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let speakerCell = tableView.dequeueReusableCell(withIdentifier: SpeakersTableViewCellIDManager.speakerCell, for: indexPath) as! SpeakerTableViewCell
        
//        speakerCell.updateUI(speaker: speakers[indexPath.row])
        
        speakerCell.dataSource = self
        
        return speakerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 143
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //到時候要傳講者資料過去 sender再設定
        
//        self.selectedSpeaker = speakers[indexPath.row]
        
        performSegue(withIdentifier: SegueIDManager.performSpeakerDetail, sender: nil)
    }
    
}

extension SpeakersViewController: SpeakerTableViewCellDataSource {
    
    func numberOfTags(_ cell: SpeakerTableViewCell) -> Int {
        
//        return tags.count
        return 0
    }
    
    func titleForTags(_ cell: SpeakerTableViewCell, index: Int) -> String {
        
//        return tags[index].rawValue
        return ""
    }
    
    func colorForTags(_ cell: SpeakerTableViewCell, index: Int) -> UIColor? {
        
//        return tags[index].color
        return nil
    }
}
