//
//  CalculateFormul.swift
//  TestConcurrency
//
//  Created by Тагир Файрушин on 21.11.2024.
//

import Foundation

struct CalculateFormul {
    func factorial(_ n: Int) -> Int {
        var result = 1
        for i in 1...n{
            result *= i
        }
        return result
    }
}
