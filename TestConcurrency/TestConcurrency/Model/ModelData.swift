//
//  ModelData.swift
//  TestConcurrency
//
//  Created by Тагир Файрушин on 21.11.2024.
//

import Foundation
import UIKit

class ModelData {
    private var photos: [UIImage] = [UIImage.photo1, UIImage.photo2, UIImage.photo3, UIImage.photo4, UIImage.photo5, UIImage.photo6, UIImage.photo7, UIImage.photo8, UIImage.photo9, UIImage.photo10]
    
    private var titleSegmentControll: [String] = ["Параллельно","Последовательно"]
    
    private var titleLabel: String = "Загрузка"
    
    private var titleButtons: [String] = ["Начать вычисление", "Отмена"]
    
    func obtainPhoto() -> [UIImage] {
        return photos
    }
    
    func obtainTitleSegment() -> [String] {
        return titleSegmentControll
    }
    
    func obtainTitleLabel() -> String {
        return titleLabel
    }
    
    func obtainTitleButton() -> [String] {
        return titleButtons
    }
}
