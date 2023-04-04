import UIKit

final class MovieQuizViewController: UIViewController, QuetionFactoryDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    // MARK: - Private Properties
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0                         // правильные ответы
    private let questionsAmount: Int = 10                       // общее количество вопросов для квиза
    private var questionFactory: QuestionFactoryProtocol?       // фабрика вопросов
    private var currentQuestion: QuizQuestion?                  // вопрос на данный момент, который видит пользователь
    private var alertPresenter = AlertPresenter()
    private var numberOfGames: Int = 0
    private var bestGame: StatisticService?
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionFactory = QuestionFactoryImpl(delegate: self)
        questionFactory?.requestNextQuestion()
        alertPresenter.viewController = self
    }
    
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    // MARK: - IBActions
    @IBAction func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
    @IBAction func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    
    
    
    
    // MARK: - Private methods
    private func reset() {
        self.numberOfGames += 1
        self.currentQuestionIndex = 0
    }
    
    
    private func date() -> String {
        let date = Date()
        let currentDate = DateFormatter()
        currentDate.dateFormat = "dd.MM.yy hh:mm"
        let now = currentDate.string(from: date)
        return now
    }
    
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {        // тут конвертируем информацию для экрана в состояние "Вопрос задан"
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    private func show(quiz step: QuizStepViewModel) {                       // здесь мы заполняем нашу картинку, текст и счётчик данными
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            self.questionFactory?.requestNextQuestion()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        imageView.layer.cornerRadius = 20
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.imageView.layer.borderWidth = 0
            self.showNextQuestionOrResults()
        }
    }
    
    
    
    private func showNextQuestionOrResults() {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        
        if currentQuestionIndex == questionsAmount - 1 {
            
            let titleText = "Этот раунд окончен!"
            let massageText = """
                    Ваш результат: \(correctAnswers)/10
                    Количество сыгранных квизов: \(numberOfGames)
                    Рекорд: \(bestGame(num: correctAnswers))/10 (\(date()))
                    Средняя точность: \(correctAnswers * 10)%
                    """
            let buttonText = "Сыграть еще раз"
            
            
            let viewModel = AlertModel(title: titleText, 
                                       message: massageText,
                                       buttonText: buttonText) { [weak self] in
                self?.currentQuestionIndex = 0
                self?.correctAnswers = 0
                
                self?.questionFactory?.requestNextQuestion()
            }
            showQuizAlert(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func showQuizAlert(quiz model: AlertModel) {
        alertPresenter.showAlert(model: model)
    }
    
    
}

