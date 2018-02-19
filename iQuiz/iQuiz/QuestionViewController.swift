//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/16/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit



class QuestionViewController: UIViewController {
    let mathQuestion = ["What's the answer for 1 + 1?", "What's the answer for 2 + 2?", "What's the answer for 2 * 3?"]
    let mathAnswer = [["2", "4", "1", "5"], ["4", "3", "2","5"], ["6", "5", "8", "7"]]
    let marvelQuestion = ["What's black widow's real name?", "Jessica Jones is married to?", "In Civil War, Captain America fought against..."]
    let marvelAnswer = [["Natalia Romanova", "Natalie Romanove", "Natalia Ravenova", "Natalie Rave"], ["Luke Cage", "Matt Murdock", "idk", "other"], ["Iron Man", "Super Man", "Nick Fury", "other"]]
    let scienceQuestion = ["What do bees make honey from?", "If I dissolve some sugar in regular water, what have I made?", "How fast do bees wings beat? (times per second)"]
    let scienceAnswer = [["Nectar", "Syrup", "Honeynut Cheerios", "Honeynut"], ["Solution", "Sweet tea", "Mixture", "Water"], ["180", "5", "50", "80"]]
    
    var question: [String] = []
    var answer: [[String]] = [[]]
    var cellPressed = -1
    var currentQuestion = 0
    var rightAnswerPlacement:UInt32 = 0
    var answerChosen : Int = -1
    var totalRight: Int = 0
    
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
            target.correctAnswer = rightAnswerPlacement
            target.questions = question
            target.answers = answer
            target.currentQuestion = currentQuestion
            target.totalRight = totalRight
        }
    }
    
    func newQuestion(){
        questionLbl.text = question[currentQuestion]
        
        rightAnswerPlacement = arc4random_uniform(3)+1
        
        var button:UIButton = UIButton()
        var x = 1
        for i in 1...4{
             button = view.viewWithTag(i) as! UIButton
            if i == Int(rightAnswerPlacement){
                button.setTitle(answer[currentQuestion][0], for: .normal)
            } else {
                button.setTitle(answer[currentQuestion][x], for: .normal)
                x += 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if cellPressed == 0 {
            question = mathQuestion
            answer = mathAnswer
        } else if cellPressed == 1 {
            question = marvelQuestion
            answer = marvelAnswer
        } else if cellPressed == 2{
            question = scienceQuestion
            answer = scienceAnswer
        }
        
         newQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
