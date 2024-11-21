//
//  CustomCollectionViewCell.swift
//  TestConcurrency
//
//  Created by Тагир Файрушин on 21.11.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCell(photo: UIImage) {
        self.photo.image = photo
    }
}

extension CustomCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
