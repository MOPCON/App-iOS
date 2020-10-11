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
    
    @IBOutlet var puzzleProgressGroup: [UIProgressView]!
    
    @IBOutlet var giftIconGroup: [UIImageView]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var puzzleCollectionView: UICollectionView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
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
        
        setupCollectionView()
        
        startSpinner()
        
        fetchGameStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "大地遊戲" : "Game"
    }
    
    private func setupCollectionView() {
        puzzleCollectionView.isHidden = false
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
                
                destination.missionID = mission.uid
                
                destination.isPassed = Bool(truncating: mission.pass as NSNumber)
            }
        } else if segue.identifier == Segue.reward {
            
            if let destination = segue.destination as? RewardViewController {
                
                destination.rewards = rewards
            }
        }
    }
    
    private func updateProgress() {
            
        puzzleProgressGroup[0].progress = Float(point / 6)
        
        puzzleProgressGroup[1].progress = (point > 6) ? Float(point / 12) : 0
        
        giftIconGroup[0].tintColor = (point >= 6) ? .secondThemeColor : .white
        
        giftIconGroup[1].tintColor = (point == 12) ? .secondThemeColor : .white
        
        scoreLabel.text = "\(point)/12"
    }
    
    private func startSpinner() {
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        view.addSubview(self.spinner)
    }
    
    func stopSpinner() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.spinner.stopAnimating()
            
            self?.spinner.removeFromSuperview()
        }
        
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
        
        var ended = false
        
        if point == 5 || point == 11 {
            
            FieldGameProvider.notifyReward(completion: { [weak self] result in
           
                switch result {

                case .success(let reward):

                    self?.noticeView.updateUI(with: .reward, and: reward as AnyObject)

                    self?.presentHintView()

                    guard let keyReward = self?.keyReward else { return }

                    UserDefaults.standard.set(false, forKey: keyReward)
                    
                    ended = true

                case .failure(let error):

                    print(error)
                }
            })
        }

        FieldGameProvider.fetchGameStatus(completion: { [weak self] result in
            
            self?.stopSpinner()
            
            switch result {
                
            case .success(let gameStatus):
                
                self?.point = gameStatus.wonPoint
                                
                self?.missions = gameStatus.missions
                
                self?.rewards = gameStatus.rewards.filter({ $0.hasWon == 1 && $0.redeemable == 1 })
                
                self?.throwToMainThreadAsync {
                    
                    self?.puzzleCollectionView.isHidden = false
                    
                    self?.puzzleCollectionView.reloadData()
                    
                    self?.updateProgress()
                }
                
                if self?.point == 12 && ended {
                    self?.noticeView.updateUI(with: .allFinish)
                    
                    self?.presentHintView()
                }
                
            case .failure(let error):
                
                switch error {
                
                case LKHTTPError.unauthError:
                    
                    let uuid = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString

                    FieldGameProvider.register(with: uuid, and: uuid, completion: {
                    
                        self?.fetchGameStatus()
                    })
                    
                default:
                    
                    print(error)
                    
                    self?.throwToMainThreadAsync {
                        
                        self?.hintLabel.isHidden = false
                    }
                }
            }
        })
    }
    
    @IBAction func goToReward(_ sender: UIButton) {
        
        performSegue(withIdentifier: Segue.reward, sender: nil)
    }
    
}

extension FieldGameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuzzleCell.identifier, for: indexPath) as! PuzzleCell
        
        guard let mission = missions?[indexPath.row] else { return cell }

        let isCompleted = Bool(truncating: mission.pass as NSNumber)
        
        let puzzleImageName = ((isCompleted) ? "pu" : "pl") + "\(indexPath.row + 1)"
        
        cell.puzzleImageView.image = UIImage(named: puzzleImageName)
        
        return cell
    }
}

extension FieldGameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.stage, sender: indexPath)
    }
}

extension FieldGameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = UIScreen.main.bounds.width - (21 * 2)
        
        let width =  (viewWidth - 3) / 4
        
        let height = (viewWidth - 2) / 3
        
        return CGSize(width: width, height: height)
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

            self?.stopSpinner()

            switch result {

            case .success(let reward):

                self?.noticeView.updateUI(with: .reward, and: reward as AnyObject)

                self?.presentHintView()

                guard let keyReward = self?.keyReward else { return }

                UserDefaults.standard.set(false, forKey: keyReward)

                self?.fetchGameStatus()

            case .failure(let error):

                print(error)
            }
        })
    }
}
