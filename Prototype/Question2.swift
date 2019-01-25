//
//  Quiz.swift
//  Prototype
//
//  Created by Zengying  You on 1/21/19.
//  Copyright © 2019 Alex Yearley. All rights reserved.
//

import UIKit

class Question: NSObject {
    var title: String
    var choices: [String]
    var correctAns: Int
    var correctAnsIndex: Int = 0
    
    init(title: String, choices: [String], correctAns: Int) {
        self.title = title
        self.choices = choices
        self.correctAns = correctAns
        super.init()
        //self.correctAnsIndex = getCorrectAnsIndex()
    }
    
    /*func getCorrectAnsIndex() -> Int {
     for (index, choice) in choices.enumerated() {
     if (choice == correctAns) {
     correctAnsIndex = index
     return correctAnsIndex
     }
     }
     debugPrint("No correct answer in available choices.")
     return -1
     }*/
    
    
}
