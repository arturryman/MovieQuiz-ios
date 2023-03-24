//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Артур Райман on 24.03.2023.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
}
