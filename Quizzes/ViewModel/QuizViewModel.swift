//
//  QuizViewModel.swift
//  Quizzes
//
//  Created by Jiseok Shim on 2026-08-06.
//

import Foundation

@Observable
class QuizViewModel{
    var questions: [TriviaQuestion] = []
    var currentQuestionIndex: Int = 0
    var shuffledAnswers: [String] = []
    var selectedAnswer: String? = nil
    var score: Int = 0
    var answeredCount: Int = 0
    var hasAnswered: Bool = false
    var isQuizCompleted: Bool = false
    
    // computed value
    
    // Current Question
    var currentQuestion: TriviaQuestion?{
        if(self.questions.isEmpty){
            return nil
        }
        if(self.currentQuestionIndex >= self.questions.count){
            return nil
        }
        return self.questions[self.currentQuestionIndex]
    }
    
    // Quiz Progress
    var progress: Double {
        if(self.questions.isEmpty){
            return 0.0
        }
        return Double(self.currentQuestionIndex + 1) / Double(self.questions.count)
    }
    
    //Correct Answer Count
    var correctCount: Int {
        return self.score
    }
    
    //Incorrect Answer Count
    var incorrectCount: Int {
        return self.answeredCount - self.score
    }
    
    // Percentage of Score
    var percentage: Int{
        if(self.questions.isEmpty){
            return 0
        }
        let result = Double(self.correctCount) / Double(self.questions.count)
        
        return Int(result * 100)
    }
    
    // Check Last Question
    var isLastQuestion: Bool{
        if(self.questions.isEmpty){
            return false
        }
        
        return self.currentQuestionIndex == self.questions.count - 1
    }
    
    // func
    func startQuiz(questions: [TriviaQuestion]){
        self.questions = questions
        self.currentQuestionIndex = 0
        self.score = 0
        self.answeredCount = 0
        self.selectedAnswer = nil
        self.hasAnswered = false
        self.isQuizCompleted = false
        
        self.prepareAnswers()
    }
    
    func prepareAnswers() {
        guard let question = self.currentQuestion else{
            self.shuffledAnswers = []
            return
        }
        self.shuffledAnswers = question.incorrectAnswers
        self.shuffledAnswers.append(question.correctAnswer)
        self.shuffledAnswers.shuffle()
    }
    
    func selectAnswer(_ answer: String){
        if(self.hasAnswered){
            return
        }
        
        guard let question = self.currentQuestion else{
            return
        }
        
        self.selectedAnswer = answer
        self.hasAnswered = true
        self.answeredCount += 1
        
        if(answer == question.correctAnswer){
            self.score += 1
        }
    }
    
    
    func moveToNextQuestion()-> Bool{
        if(!self.hasAnswered){
            return false
        }
        
        if(self.isLastQuestion){
            self.isQuizCompleted = true
            return false
        }
        
        self.currentQuestionIndex += 1
        self.selectedAnswer = nil
        self.hasAnswered = false
        
        self.prepareAnswers()
        
        return true
    }
    
    
    func restartQuiz(){
        self.startQuiz(questions: self.questions)
    }
}
