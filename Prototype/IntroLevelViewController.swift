//
//  IntroLevelViewController.swift
//  Prototype
//
//  Created by Alex Yearley on 12/1/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit

class IntroLevelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        readTextFile()
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: "example", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
            } catch {
                debugPrint("contents of text file could not be loaded")
            }
        } else {
            debugPrint("text file not found")
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
