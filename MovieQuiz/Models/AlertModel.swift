//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Артур Райман on 23.03.2023.
//

import Foundation
import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    var completion: (() -> Void)?
}
