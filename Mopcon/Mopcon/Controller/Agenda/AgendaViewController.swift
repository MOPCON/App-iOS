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
        
        static let unConf = "SegueUnConf"
    }
    
    @IBOutlet weak var dateSelectionView: SelectionView!
    
    @IBOutlet weak var scheduleSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var sessionContainerView: UIView!
    
    @IBOutlet weak var unconfContainerView: UIView!
    
    @IBOutlet weak var favirateContainerView: UIView!
    
    private var sessionLists: [SessionList] = []
    
    private var sessionViewController: SessionsViewController?
    
    private var unconfViewController: UnConferenceViewController?
    
    private var favoriteController: FavoriteViewController?
    
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
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                ],
                for: .normal
            )
            
            scheduleSegmentedControl.layer.borderWidth = 1
            scheduleSegmentedControl.layer.borderColor = UIColor.pink?.cgColor
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
            
        case Segue.favorite:
            
            guard let favoriteVC = segue.destination as? FavoriteViewController else {
                return
            }
            
            favoriteController = favoriteVC
            
        case Segue.unConf:
            
            guard let unconfVC = segue.destination as? UnConferenceViewController else {
                return
            }
            
            unconfViewController = unconfVC
            
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
                    
                    self?.sessionViewController?.updateData(
                        sessions: sessionLists[strongSelf.dateSelectionView.seletedIndex!].period
                    )
                    
                    self?.favoriteController?.selectedDate = sessionLists.first?.date
                }
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    @IBAction func chooseScheduleAction(_ sender: UISegmentedControl) {
        
        resetContainerViewState()
        
        switch sender.selectedSegmentIndex {
            
        case 0: sessionContainerView.isHidden = false
            
        case 1: unconfContainerView.isHidden = false
           
        case 2: favirateContainerView.isHidden = false
        default: break
        
        }
    }
    
    func resetContainerViewState() {
        
        sessionContainerView.isHidden = true
        
        favirateContainerView.isHidden = true
        
        unconfContainerView.isHidden = true
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
    
        sessionViewController?.updateData(sessions: sessionLists[index].period)
        
        unconfViewController?.selectedIndex = index
        
        favoriteController?.selectedDate = sessionLists[index].date
    }
}
