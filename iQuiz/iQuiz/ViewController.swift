//
//  ViewController.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/11/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit
import Foundation

struct QuizInfo: Decodable {
    let title: String
    let desc: String?
    let questions: [Question]
}

struct Question: Decodable {
    let text: String
    let answer: String
    let answers: [String]
}

struct QuizJson: Decodable{
    let data: [Question]?
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func settingPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Setting Alert", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in }))
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBOutlet weak var subjectTableView: UITableView!
    
    let subjectList = ["Mathematics", "Marvel Super Heroes", "Science"]
    let subjectDescription = ["Test your math skills", "All about Marvel", "Test your science skills"]
    var myIndex = 0
    
    override func viewDidLoad() {
        
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
        
        subjectTableView.tableFooterView = UIView()
        
        let jsonUrlString = "http://tednewardsandbox.site44.com/questions.json"
        guard let url = URL(string: jsonUrlString) else {
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with:url) {(data, response, error) in
            guard let data = data else {return}
            do{
                let quizInfo = try JSONDecoder().decode([QuizInfo].self, from: data)
                
            } catch let jsonError{
                print(jsonError)
            }
        }.resume()
        
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subjectTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.catName.text = subjectList[indexPath.row]
        cell.catDetails.text = subjectDescription[indexPath.row]
        cell.catIcon.image = UIImage(named: "category")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "CategoryToQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let target = segue.destination as! QuestionViewController
        
        target.cellPressed = myIndex
    }

    

}

