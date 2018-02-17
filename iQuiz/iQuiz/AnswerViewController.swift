//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/16/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var currentAnswer : Int = -1
    var correctAnswer : UInt32 = 0
    var questions: [String] = [] {
        didSet {
            print("questions passed to answer \(questions)" )
        }
    }
    var answers : [[String]] = [[]]
    var currentQuestion : Int = -1 {
        didSet{
            print(currentQuestion)
        }
    }
    var totalRight : Int = 0
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var correctAnsLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBAction func nextBtn(_ sender: UIButton) {
        if(currentQuestion == questions.count - 1){
            performSegue(withIdentifier: "Finished", sender: self)
        }else{
            performSegue(withIdentifier: "MoreQuestion", sender: self)
        }
    }
    

    
    func display(){
        questionLbl.text = questions[currentQuestion]
        correctAnsLbl.text = "The correct answer is: \(answers[currentQuestion][0])"
        if currentAnswer == Int(correctAnswer){
            statusLbl.text = "You got it right!"
            totalRight += 1
        } else {
            statusLbl.text = "You got it wrong."
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         display()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MoreQuestion"){
            let target = segue.destination as! QuestionViewController
            currentQuestion += 1
            target.answer = answers
            target.question = questions
            target.totalRight = totalRight
            target.currentQuestion = currentQuestion
            
        }else if(segue.identifier == "Finished"){
           let target = segue.destination as! FinishedViewController
            target.totalQuestion = questions.count
            target.totalRight = totalRight
        }
    }

    

}
