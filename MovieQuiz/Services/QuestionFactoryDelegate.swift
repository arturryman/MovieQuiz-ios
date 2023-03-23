//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Артур Райман on 21.03.2023.
//

import Foundation

protocol QuetionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
