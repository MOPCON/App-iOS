//
//  SpeakersViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class SpeakersViewController: MPBaseViewController {
    
    private struct Segue {
        
        static let detail = "SegueSpeakerDetail"
    }
    
    override var hidesBottomBarWhenPushed: Bool {
        
        get {
            return true
        }
        
        set {
            
        }
    }
    
    @IBOutlet weak var speakersTableView: UITableView!
    
    var speakers: [Speaker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSpeakers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.detail {
        
            if let vc = segue.destination as? SpeakerDetailViewController,
               let speaker = sender as? Speaker {
                
                vc.speaker = speaker
            }
        }
    }
    
    func fetchSpeakers() {
        
        SpeakerProvider.fetchSpeakers(completion: { [weak self] result in
            
            switch result {
                
            case .success(let speakers):
                
                self?.speakers = speakers
                
                self?.throwToMainThreadAsync {
                    
                    self?.speakersTableView.reloadData()
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}

extension SpeakersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return speakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let speakerCell = tableView.dequeueReusableCell(
            withIdentifier: SpeakerTableViewCell.identifier,
            for: indexPath
        ) as! SpeakerTableViewCell
        
        speakerCell.updateUI(speaker: speakers[indexPath.row])
        
        return speakerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 143
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Segue.detail, sender: speakers[indexPath.row])
    }
}
