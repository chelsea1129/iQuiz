//
//  CustomTableViewCell.swift
//  iQuiz
//
//  Created by Qiaosi Wang on 2/11/18.
//  Copyright © 2018 Qiaosi Chelsea Wang. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var catDetails: UILabel!
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catIcon: UIImageView!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
