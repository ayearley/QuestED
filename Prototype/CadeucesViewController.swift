//
//  CadeucesViewController.swift
//  Prototype
//
//  Created by Jacob Zeitlin on 12/8/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit

class CadeucesViewController: UIViewController {

    var textFile: String
    var levelRunner: LevelRunner
    
    init(runner: LevelRunner) {
        levelRunner = runner
        textFile = runner.levelText
        print("Text file: \(textFile)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.textFile = ""
        self.levelRunner = LevelRunner(textIn: self.textFile)
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        readTextFile()
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let cadeucesRange = contents.range(of: "*CADEUCES*:\n")
                let endRange = contents.range(of: "*END*")
                
                let cadeucesText = contents[cadeucesRange!.upperBound..<endRange!.lowerBound]
                
                print(cadeucesText)
                
                // introLabel.text = String(introText)
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
