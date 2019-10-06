//
//  CommunicationViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class CommunicationViewController: MPBaseViewController {
    
    private struct Segue {
        
        static let unconf = "SegueUnConf"
    }
    
    private var unconfVC: UnConferenceViewController?

    @IBOutlet weak var dateSelectionView: SelectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateSelectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.unconf {
            
            guard let destination = segue.destination as? UnConferenceViewController else { return }
            
            unconfVC = destination
        }
    }
}

extension CommunicationViewController: SelectionViewDataSource {
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String {
        
        return (index == 0) ? "10/19" : "10/20"
    }
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
        
        unconfVC?.selectedIndex = index
    }
}
