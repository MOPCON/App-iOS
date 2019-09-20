//
//  MissionListViewController.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/8/28.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

class FieldGameViewController: MPBaseViewController, NoticeViewPresentable {
    
    private var missions: [Mission]?
    
    private var rewards: [Reward]?
    
    private let spinner = LoadingTool.setActivityindicator()
    
    private var point: Int = 0

    private struct Segue {
        
        static let stage = "SegueStage"
        
        static let reward = "SegueReward"
    }
    
    @IBOutlet weak var headerView: FieldGameHeaderView! {
        
        didSet {
        
            headerView.delegate = self
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    private let keyFieldGame = "isOpenFieldGame"
    
    var shouldOpenNoticeView: Bool {
        
        return !UserDefaults.standard.bool(forKey: keyFieldGame)
    }
    
    private let keyReward = "hasOpenedReward"
    
    var shouldEnableRewardButton: Bool {

        return UserDefaults.standard.bool(forKey: keyReward)
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        startSpinner()
        
        fetchGameStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "遊戲" : "Game"
    }
    
    private func setupTableView() {
        
        headerView.frame.size.height = 170
        
        tableView.tableHeaderView = headerView
        
        let nib = UINib(
            nibName: GameStageCell.identifier,
            bundle: nil
        )
        
        tableView.register(
            nib,
            forCellReuseIdentifier: GameStageCell.identifier
        )
        
        let completeNib = UINib(
            nibName: CompleteCell.identifier,
            bundle: nil
        )
        
        tableView.register(
            completeNib,
            forCellReuseIdentifier: CompleteCell.identifier
        )
        
        tableView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldOpenNoticeView {
            
            fetchIntro()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.stage {
        
            if let destination = segue.destination as? StageViewController, let indexPath = sender as? IndexPath, let mission = missions?[indexPath.row] {
                
                destination.isLast = (indexPath.row == ((missions?.count ?? 0) - 1))
                
                destination.missionID = mission.uid
                
                destination.isPassed = Bool(truncating: mission.pass as NSNumber)
            }
        } else if segue.identifier == Segue.reward {
            
            if let destination = segue.destination as? RewardViewController {
                
                destination.rewards = rewards
            }
        }
    }
    
    private func updateHeadView() {
        
        headerView.scoreLabel.text = "\(point)"
        
        headerView.levelLabel.text = "\(point)/\(missions?.count ?? 0)"
    }
    
    private func startSpinner() {
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        view.addSubview(self.spinner)
    }
    
    func stopSpinner() {
        
        spinner.stopAnimating()
        
        spinner.removeFromSuperview()
    }
    
    private func fetchIntro() {
        
        FieldGameProvider.fetchIntro(completion: { [weak self] result in
            
            switch result {
                
            case .success(let intro):
                
                self?.noticeView.updateUI(with: .welcome, and: intro as AnyObject)
                
                self?.presentHintView()
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
    
    func fetchGameStatus() {
        
        FieldGameProvider.fetchGameStatus(completion: { [weak self] result in
            
            switch result {
                
            case .success(let gameStatus):
                
                self?.point = gameStatus.wonPoint
                                
                self?.missions = gameStatus.missions
                
                self?.rewards = gameStatus.rewards.filter({ $0.hasWon == 1 })
                
                self?.updateHeadView()
                
                self?.stopSpinner()
                
                self?.tableView.isHidden = false
                
                self?.tableView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}

extension FieldGameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return missions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GameStageCell.identifier,
            for: indexPath)
        
        guard let stageCell = cell as? GameStageCell else { return cell }
        
        guard let mission = missions?[indexPath.row] else { return cell }
        
        let isCompleted = Bool(truncating: mission.pass as NSNumber)
        
        stageCell.updateUI(with: mission, and: isCompleted)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {

        return 112
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = tableView.dequeueReusableCell(
            withIdentifier: CompleteCell.identifier
        ) as! CompleteCell
        
        let isCompleted = (point == missions?.count)
        
        footer.updateUI(with: isCompleted, and: shouldEnableRewardButton)
        
        footer.delegate = self
        
        return footer
    }
}

extension FieldGameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let stageCell = cell as? GameStageCell else { return }
        
        if let missions = self.missions {
            
            let firstNotPassedIndex = missions.firstIndex(where: { $0.pass == 0})
            
            if firstNotPassedIndex == indexPath.row {
                
                stageCell.startTimer()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        guard let stageCell = cell as? GameStageCell else { return }

        if let missions = self.missions {

            let firstNoPassedIndex = missions.firstIndex(where: { $0.pass == 0})

            if firstNoPassedIndex == indexPath.row {

                stageCell.stopTimer()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Segue.stage, sender: indexPath)
    }
}

extension FieldGameViewController: NoticeViewDelegate {
    func didTouchOKButton(_ noticeView: NoticeView, type: NoticeType) {
        
        if type == .welcome {
            
            UserDefaults.standard.set(true, forKey: keyFieldGame)
        }
    }
}

extension FieldGameViewController: FieldGameHeaderViewDelegate {
    
    func didTouchRewardBtn(_ headerView: FieldGameHeaderView) {
        
        performSegue(withIdentifier: Segue.reward, sender: nil)
    }
}

extension FieldGameViewController: FieldGameCompleteViewDelegate {

    func didTouchRewardBtn() {
        
        startSpinner()
        
        FieldGameProvider.notifyReward(completion: { [weak self] result in
            
            switch result {
                
            case .success(let reward):
                
                self?.noticeView.updateUI(with: .reward, and: reward as AnyObject)
                
                self?.presentHintView()
                
                self?.stopSpinner()

                guard let keyReward = self?.keyReward else { return }
                
                UserDefaults.standard.set(false, forKey: keyReward)
                
                self?.tableView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        })
    }
}
