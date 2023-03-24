//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Артур Райман on 24.03.2023.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gameCount: Int { get }
    var bestGame: GameRecord { get }
}

final class StatisticServiceImplementation: StatisticService {
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
    var totalAccuracy: Double
    
    var gameCount: Int
    
    var bestGame: GameRecord {
        get {
            
        }
        
        set {
            
        }
    }
    
    
}
