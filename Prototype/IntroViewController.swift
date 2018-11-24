//
//  IntroViewController.swift
//  Prototype
//
//  Created by Alex Yearley on 11/24/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var WelcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           Bundle.main.loadNibNamed("IntroViewController", owner: self, options: nil)
        self.WelcomeLabel.text = "Welcome to QuestED";
        // Do any additional setup after loading the view.
    }

    @IBAction func toMap(_ sender: Any) {
        self.navigationController?.pushViewController(MapViewController(), animated: true)
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
