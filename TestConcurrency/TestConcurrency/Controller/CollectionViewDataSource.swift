//
//  CollectionViewDataSource.swift
//  TestConcurrency
//
//  Created by Тагир Файрушин on 21.11.2024.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject {
    
    var dataSource: UICollectionViewDiffableDataSource<SectionCollectionView, UIImage>?
    var photos: [UIImage]
    
    init(collectionView: UICollectionView, photos: [UIImage]) {
        self.photos = photos
        super.init()
        self.configureDataSource(collectionView: collectionView)
        
    }
    
    private func configureDataSource(collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<SectionCollectionView, UIImage>(collectionView: collectionView, cellProvider: { collectionView, indexPath, image in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
            cell.configureCell(photo: self.photos[indexPath.item])
            
            return cell
        })
        applySnapshot(photos: photos, animated: true)
    }
    
    private func applySnapshot(photos: [UIImage], animated: Bool) {
        var snapshot = dataSource?.snapshot() ?? NSDiffableDataSourceSnapshot<SectionCollectionView, UIImage>()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func replaceItem(newItem: UIImage, oldItem: UIImage, animated: Bool) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.insertItems([newItem], beforeItem: oldItem)
        snapshot.deleteItems([oldItem])
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
}
