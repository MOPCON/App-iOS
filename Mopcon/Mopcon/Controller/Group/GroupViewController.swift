//
//  CommunityViewController.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/2.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

private enum GroupType {
    
    case host
    
    case volunteer
    
    func title() -> String {
        
        switch self {
            
        case .host: return "參與社群"
            
        case .volunteer: return "主辦團隊"
        
        }
    }
}

class GroupViewController: MPBaseViewController {
    
    @IBOutlet weak var communityImageContainerView: UIView!
    
    @IBOutlet weak var volunteerContainerView: UIView!
    
    @IBOutlet weak var selectionView: SelectionView! {
        
        didSet {
        
            selectionView.dataSource = self
        }
    }
    
    private let selectionDatas: [GroupType] = [.host, .volunteer]
    
    let spinner = LoadingTool.setActivityindicator()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        volunteerContainerView.isHidden = true
        
        spinner.startAnimating()
        
        spinner.center = view.center
        
        view.addSubview(spinner)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CurrentLanguage.getLanguage() == Language.english.rawValue {
            self.navigationItem.title = "Group"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIDManager.performCommunityContainerView {
        
            (segue.destination as! GroupHostViewController).delegate = self
        }
    }
}
extension GroupViewController: GroupHostViewControllerDelegate {
    
    func stopSpinner() {
        
        spinner.stopAnimating()
        
        spinner.removeFromSuperview()
    }
}

extension GroupViewController: SelectionViewDataSource {
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String {
        
        return selectionDatas[index].title()
    }
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
        
        switch selectionDatas[index] {
        
        case .host:
            
            communityImageContainerView.isHidden = false
            
            volunteerContainerView.isHidden = true
            
        case .volunteer:
        
            communityImageContainerView.isHidden = true
            
            volunteerContainerView.isHidden = false
        }
    }
}
