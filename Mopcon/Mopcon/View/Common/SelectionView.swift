//
//  SelectionIndicatorView.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/7/19.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import UIKit

protocol SelectionViewDataSource: AnyObject {
    
    func numberOfButton(_ selectionView: SelectionView) -> Int
    
    func titleOfButton(_ selectionView: SelectionView, at index: Int) -> String
    
    func colorOfTitleInButton(_ selectionView: SelectionView, at index: Int) -> UIColor?

    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor?
    
    func didSelectedButton(_ selectionView: SelectionView, at index: Int)
    
    func initialButtonIndex(_ selectionView: SelectionView) -> Int
}

extension SelectionViewDataSource {
    
    func numberOfButton(_ selectionView: SelectionView) -> Int { return 2 }
    
    func colorOfTitleInButton(_ selectionView: SelectionView, at index: Int) -> UIColor? { return UIColor.white }
    
    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor? { return UIColor.azure }
    
    func initialButtonIndex(_ selectionView: SelectionView) -> Int { return 0 }
}

class SelectionView: UIView {

    weak var dataSource: SelectionViewDataSource? {
        
        didSet {
        
            setupSelectionViews()
        
            setupIndicatorView()
        }
    }
    
    //MARK: - Private view object
    private var stackView: UIStackView = {
        
        let stack = UIStackView()
        
        stack.axis = NSLayoutConstraint.Axis.horizontal
        
        stack.distribution = UIStackView.Distribution.fillEqually
        
        return stack
    }()
    
    private let indicatorView = UIView()
    
    private var indicatorCenterXContraint: NSLayoutConstraint?
    
    //MARK: - Set up subViews
    private func setupSelectionViews() {
        
        guard let dataSource = dataSource else { return }
        
        for index in 0...(dataSource.numberOfButton(self)-1) {
            
            let button = UIButton()
            
            button.tag = index
            
            button.setTitle(dataSource.titleOfButton(self, at: index), for: .normal)
            
            button.setTitleColor(dataSource.colorOfTitleInButton(self, at: index), for: .normal)
            
            button.addTarget(
                self,
                action: #selector(userDidTouchButton(_:)),
                for: .touchUpInside
            )
            
            stackView.addArrangedSubview(button)
        }
        
        addAndStickSubView(stackView)
    }
    
    private func setupIndicatorView() {
        
        guard let dataSource = dataSource,
              let firstView = stackView.arrangedSubviews.first
        else {
            return
        }
        
        indicatorView.backgroundColor = dataSource.colorOfIndicator(self)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicatorView)
        
        indicatorCenterXContraint = indicatorView.centerXAnchor.constraint(equalTo: firstView.centerXAnchor)
        
        NSLayoutConstraint.activate([
        
            indicatorView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2),
            indicatorView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 80.0 / 375.0),
            indicatorCenterXContraint!
            
        ])
    }

    //MARK: - Action
    @objc private func userDidTouchButton(_ sender: UIButton) {
        
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: { [weak self] in
        
            self?.indicatorCenterXContraint?.isActive = false
            
            self?.indicatorCenterXContraint = self?.indicatorView.centerXAnchor.constraint(equalTo: sender.centerXAnchor)
            
            self?.indicatorCenterXContraint?.isActive = true
            
            self?.layoutIfNeeded()
        })
        
        animator.startAnimation()
        
        dataSource?.didSelectedButton(self, at: sender.tag)
    }
}
