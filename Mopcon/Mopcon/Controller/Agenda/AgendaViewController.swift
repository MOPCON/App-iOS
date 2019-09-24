//
//  AgendaViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/4.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class AgendaViewController: MPBaseViewController {
    
    struct Segue {
        
        static let sessions = "SegueSessions"
        
        static let favorite = "SegueFavorite"
        
        static let interChange = "SegueInterChange"
    }
    
    @IBOutlet weak var dateSelectionView: SelectionView!
    
    @IBOutlet weak var scheduleSegmentedControl: UISegmentedControl!
    
    var sessionLists: [SessionList] = []
    
    private var sessionViewController: SessionsViewController?
    
    private let spinner = LoadingTool.setActivityindicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleSegmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
            ],
            for: .selected
        )

        if #available(iOS 13, *) {
            scheduleSegmentedControl.setTitleTextAttributes(
                [
                    NSAttributedString.Key.foregroundColor: UIColor.azure ?? UIColor.blue,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                ],
                for: .normal
            )
            
            scheduleSegmentedControl.layer.borderWidth = 1
            scheduleSegmentedControl.layer.borderColor = UIColor.azure?.cgColor
            scheduleSegmentedControl.backgroundColor = UIColor.dark
        }
        
        fetchSessions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            
            self.navigationItem.title = "Agenda"
            
            scheduleSegmentedControl.setTitle("Schedule", forSegmentAt: 0)
            
            scheduleSegmentedControl.setTitle("Favorite", forSegmentAt: 1)
            
            scheduleSegmentedControl.setTitle("Communication", forSegmentAt: 2)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.sessions:
            
            guard let sessionVC = segue.destination as? SessionsViewController else {
                return
            }
            
            sessionViewController = sessionVC
            
        case Segue.favorite: break
            
        case Segue.interChange: break
            
        default: break
            
        }
    }
    
    func fetchSessions() {
        
        SessionProvider.fetchAllSession(completion: { [weak self] result in
            
            switch result {
                
            case .success(let sessionLists):
                
                self?.sessionLists = sessionLists
                
                self?.throwToMainThreadAsync {
                    
                    guard let strongSelf = self else { return }
                    
                    self?.dateSelectionView.dataSource = self
                    
                    self?.sessionViewController?.sessions = sessionLists[strongSelf.dateSelectionView.seletedIndex!].period
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    @IBAction func chooseScheduleAction(_ sender: UISegmentedControl) {
        
    
    }
}

// MARK : Tableview Datasource & Tableview Delegate

extension AgendaViewController: ConferenceTableViewCellDelegate {
    
    func whichCellButtonDidTapped(sender: UIButton, index: IndexPath) {
   
    }
    
}

extension AgendaViewController: SelectionViewDataSource {
    
    func numberOfButton(_ selectionView: SelectionView) -> Int {
        
        return sessionLists.count
    }
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String {
        
        return sessionLists[index].dateString
    }
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
    
        sessionViewController?.sessions = sessionLists[index].period
    }
}
