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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let jsonUrlString = UserDefaults.standard.string(forKey: "url") ?? "http://tednewardsandbox.site44.com/questions.json"
    @IBOutlet weak var subjectTableView: UITableView!
    var subjectList: [String] = []
    var subjectDescription: [String] = []
    //    var questions: [Question] = []
    //    var answers: [[String]] = [[]]
    //    var correctIndex: Int = -1
    var quizInfo: [QuizInfo]?
    var myIndex = 0
    var urlTextField: UITextField = UITextField()
    
    
    override func viewDidLoad() {
        
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
        
        subjectTableView.tableFooterView = UIView()
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if(Reachability.isConnectedToNetwork()){
            fetchData(jsonUrlString)
        }else{
            let alert = UIAlertController(title: "Network Unavailable", message: "Will attempt to use local data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated:true, completion: nil)
            do{
                let data = UserDefaults.standard.data(forKey: "data")
                // fetch JSON data
                self.quizInfo = try JSONDecoder().decode([QuizInfo].self, from: data!)
                self.subjectDescription = []
                self.subjectList = []
                // store JSON data in vars
                var temp: Int = 0
                while temp < (self.quizInfo?.count)! {
                    self.subjectList.append(self.quizInfo![temp].title)
                    self.subjectDescription.append(self.quizInfo![temp].desc!)
                    temp += 1
                }
            } catch{
                let alert = UIAlertController(title: "No Data Error", message: "connect to internet to fetch quiz data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated:true, completion: nil)
            }
            DispatchQueue.main.async{
                self.subjectTableView.reloadData()
            }
            
        }
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
    
    @IBAction func settingPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Setting Alert", message: "Enter url of Json here", preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            self.urlTextField = textField
            self.urlTextField.placeholder = "enter your json url here"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Check now", style: UIAlertActionStyle.default, handler:{
            (_ :UIAlertAction) in
            if self.urlTextField.text != nil {
                self.fetchData(self.urlTextField.text!)
            }
        }))
        self.present(alert, animated:true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let target = segue.destination as! QuestionViewController
        
        target.cellPressed = myIndex
        target.quizInfo = quizInfo
    }
    
    
    func fetchData(_ jsonUrlString: String){
        guard let url = URL(string: jsonUrlString) else {
            return
        }
        
        URLSession.shared.dataTask(with:url) {(data, response, error) in
            guard let data = data else {
                let alert = UIAlertController(title: "Download Error", message: "Something went wrong during data fetch, check your URL and retry", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated:true, completion: nil)
                return
            }
            UserDefaults.standard.set(data, forKey: "data")
            UserDefaults.standard.set(jsonUrlString, forKey: "url")
            do{
                // fetch JSON data
                self.quizInfo = try JSONDecoder().decode([QuizInfo].self, from: data)
                self.subjectList = []
                self.subjectDescription = []
                // store JSON data in vars
                var temp: Int = 0
                while temp < (self.quizInfo?.count)! {
                    self.subjectList.append(self.quizInfo![temp].title)
                    self.subjectDescription.append(self.quizInfo![temp].desc!)
                    temp += 1
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            DispatchQueue.main.async{
                self.subjectTableView.reloadData()
            }
            }.resume()
    }
    
}

