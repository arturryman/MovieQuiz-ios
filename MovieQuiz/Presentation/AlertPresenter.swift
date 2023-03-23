//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Артур Райман on 23.03.2023.
//

import Foundation
import UIKit

class AlertPresenter {
    weak var viewController: UIViewController?
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(title: model.title,
                                      message: model.message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText,
                                   style: .default) { _ in
            model.completion?()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
