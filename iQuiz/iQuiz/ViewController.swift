//
//  ViewController.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/11/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func settingPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Setting Alert", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in }))
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBOutlet weak var subjectTableView: UITableView!
    
    let subjectList = ["Mathematics", "Marvel Super Heroes", "Science"]
    let subjectDescription = ["Test your math skills", "All about Marvel", "Test your science skills"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
        
        subjectTableView.tableFooterView = UIView()
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
    



}

