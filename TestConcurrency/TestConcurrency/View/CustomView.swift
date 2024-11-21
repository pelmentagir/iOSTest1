//
//  CustomView.swift
//  TestConcurrency
//
//  Created by Тагир Файрушин on 21.11.2024.
//

import UIKit

class CustomView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 15, height: (UIScreen.main.bounds.width / 2) - 15)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = .systemBlue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var segmentControll: UISegmentedControl = {
        let segmentControll = UISegmentedControl()
        segmentControll.selectedSegmentIndex = 0
        segmentControll.layer.cornerRadius = 20
        segmentControll.backgroundColor = .white
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentControll
    }()
    
    lazy var buttonCalculation: UIButton = {
        let button = UIButton(configuration: .filled())
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonCancelCalculation: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        addSubview(progressView)
        addSubview(label)
        addSubview(buttonCalculation)
        addSubview(segmentControll)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Constraints.medium.rawValue),
            label.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 20),
            
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 7),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.medium.rawValue),
            progressView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 20),
            progressView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.01),
            
            buttonCalculation.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constraints.medium.rawValue),
            buttonCalculation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.medium.rawValue),
            buttonCalculation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.medium.rawValue),
            
            segmentControll.topAnchor.constraint(equalTo: buttonCalculation.bottomAnchor, constant: Constraints.large.rawValue),
            segmentControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.medium.rawValue),
            segmentControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.medium.rawValue),
            segmentControll.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
            
            collectionView.topAnchor.constraint(equalTo: segmentControll.bottomAnchor, constant: Constraints.medium.rawValue),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.medium.rawValue),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.medium.rawValue),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.small.rawValue)
            
        ])
    }

}

