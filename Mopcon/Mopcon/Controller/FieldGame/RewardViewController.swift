//
//  RewardViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/30.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class RewardViewController: MPBaseViewController, NoticeViewPresentable {
    
    var rewards: [Reward]?
    
    private var uid: String? = ""
    
    //MARK: - HintViewPresentable
    lazy var noticeView: NoticeView = {
        
        let tempNoticeView = NoticeView(frame: CGRect.zero)
        
        tempNoticeView.delegate = self
        
        return tempNoticeView
    }()
    
    lazy var targetFrame: CGRect = {
        
        let targetWidth = UIScreen.main.bounds.size.width - 40
        
        let targetHeight = UIScreen.main.bounds.size.height * 368 / 667
        
        return CGRect(
            x: UIScreen.main.bounds.size.width / 2 - 0.5 * targetWidth,
            y: UIScreen.main.bounds.size.height / 2 - 0.5 * targetHeight,
            width: targetWidth,
            height: targetHeight
        )
    }()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        
        let xib = UINib(nibName: PresentCell.identifier, bundle: nil)
        
        tableView.register(xib, forCellReuseIdentifier: PresentCell.identifier)
    }
    
    private func updateMissionTableView() {
        
        if let parentViewController = navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as? FieldGameViewController {
            
            parentViewController.fetchGameStatus()
        }
    }
}

extension RewardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return rewards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PresentCell.identifier, for: indexPath) as? PresentCell, let reward = rewards?[indexPath.row] else { return PresentCell()}
        
        cell.delegate = self
        
        cell.updateUI(with: reward)
        
        return cell
    }
}

extension RewardViewController: NoticeViewDelegate {
    
    func didTouchOKButton(_ noticeView: NoticeView, type: NoticeType) {
        
        if let vKey = noticeView.passwordTextField.text, !vKey.isEmpty {
            
            FieldGameProvider.verify(with: .reward, and: uid!, and: vKey, completion: { [weak self] result in
                
                switch result {
                    
                case .success(_):
                    
                    guard let index = self?.rewards?.firstIndex(where: { $0.uid == self?.uid}) else { return }
                    
                    self?.tableView.beginUpdates()
                    
                    (self?.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PresentCell)?.updateButton(with: true)
                    
                    self?.tableView.endUpdates()
                    
                    self?.updateMissionTableView()
                    
                case .failure(let error):
                    
                    print(error)
                    
                    let title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "通知" : "Info"
                    
                    let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                   
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    self?.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
}

extension RewardViewController: FieldGameRewardViewDelegate {
    
    func didTouchRewardBtn(with uid: String) {
        
        self.uid = uid
        
        noticeView.updateUI(with: .exchange)
        
        presentHintView()
    }
}
