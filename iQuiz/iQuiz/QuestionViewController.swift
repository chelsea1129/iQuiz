//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/16/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions: [String] = []
    var answers : [[String]] = []
    var cellPressed = -1
    var currentQuestion = 0
    var answerChosen : Int = -1
    var totalRight: Int = 0
    var quizInfo: [QuizInfo]?
    var questionObjects: [Question] = []
    var correctIndex = -1
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBAction func answerBtn(_ sender: UIButton) {
        answerChosen = sender.tag
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "QuestionToAnswer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "QuestionToAnswer"){
            let target = segue.destination as! AnswerViewController
            
            target.currentAnswer = answerChosen
            target.correctAnswer = correctIndex
            target.questions = questions
            target.answers = answers
            target.currentQuestion = currentQuestion
            target.totalRight = totalRight
            target.questionObjects = questionObjects
            target.cellPressed = cellPressed
            target.quizInfo = quizInfo
        }
    }
    
    func newQuestion(){
        questionLbl.text = questions[currentQuestion]
        self.correctIndex = Int(questionObjects[currentQuestion].answer)!
        
        var button:UIButton = UIButton()
        for i in 1...4{
            button = view.viewWithTag(i) as! UIButton
            button.setTitle(answers[currentQuestion][i-1], for: .normal)
        }
    }
    
    func initialization() {
        self.questionObjects = quizInfo![cellPressed].questions
        
        var temp: Int = 0
        while temp < self.questionObjects.count {
            self.answers.append(self.questionObjects[temp].answers)
            self.questions.append(self.questionObjects[temp].text)
            temp += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if questions == [] {
            initialization()
        }
        newQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
