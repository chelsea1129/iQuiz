//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/16/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    var totalRight : Int = 0
    var totalQuestion: Int = 0
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(totalQuestion <= 0){
            //something is wrong
        }else{
            
            let score: Double = Double(totalRight)/Double(totalQuestion)
            var msg: String = ""
            
            if(score < 0.5){
                msg = "Sorry, you failed"
            }else if( score > 0.6 && score < 1){
                msg = "Good job!"
            }else if( score == 1){
                msg = "Nice job! You got 100%!"
            }
            
            lblScore.text = "Your score is: \(totalRight) / \(totalQuestion)"
            lblMessage.text = msg
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
