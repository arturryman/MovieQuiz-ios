//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Артур Райман on 14.03.2023.
//

import Foundation

protocol Question {
    var question: [QuizQuestion] {get set}
}

protocol QuestionFactory {
    func requestionNextQuetion()
}


final class QuestionFactoryImpl: QuestionFactoryProtocol {
   private weak var delegate: QuetionFactoryDelegate?
    init(delegate: QuetionFactoryDelegate?) {
        self.delegate = delegate
    }
    
    
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
        
    ]
    
    weak var delegate: QuetionFactoryDelegate?

       init(delegate: QuetionFactoryDelegate) {
           self.delegate = delegate
       }
       
       func requestNextQuestion() {
           guard let index = (0..<questions.count).randomElement() else {          // рандом с выбором вопроса
               delegate?.didReceiveNextQuestion(question: nil)
               return
           }
           
           let question = questions[safe: index]
           delegate?.didReceiveNextQuestion(question: question)
       }
   }
