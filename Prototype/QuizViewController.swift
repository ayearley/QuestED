//
//  QuizViewController.swift
//  Prototype
//
//  Created by Jack Bloomfeld on 1/20/19.
//  Copyright © 2019 Alex Yearley. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var textFile: String
    var levelRunner: LevelRunner
    
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var quizLabel: UILabel!
    
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
        
        let continueButton = UIButton(type: .custom)
        continueButton.frame = CGRect(x: Double(screenSize.width) * 0.75, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10)
        continueButton.setImage(UIImage(named: "continue.png"), for: .normal)
        continueButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let quizRange = contents.range(of: "*QUIZ*:\n")
                let endQuizRange = contents.range(of: "*END*")
                
                let quizText = contents[quizRange!.upperBound..<endQuizRange!.lowerBound]
                
                let questionRange = contents.range(of: "*QUIZ*:\n")
                let endQuestionRange = contents.range(of: "a1:")
                
                let questionText = contents[questionRange!.upperBound..<endQuestionRange!.lowerBound]
                
                let a1Range = contents.range(of: "a1:")
                let enda1Range = contents.range(of: "a2:")
                
                let a1Text = contents[a1Range!.upperBound..<enda1Range!.lowerBound]
                
                let a2Range = contents.range(of: "a2:")
                let enda2Range = contents.range(of: "a3:")
                
                let a2Text = contents[a2Range!.upperBound..<enda2Range!.lowerBound]
                
                let a3Range = contents.range(of: "a3:")
                let enda3Range = contents.range(of: "*END*")
                
                let a3Text = contents[a3Range!.upperBound..<enda3Range!.lowerBound]
                
                print(questionText)
                print(a1Text)
                print(a2Text)
                print(a3Text)
                
                //quizLabel.text = String(quizText)
            } catch {
                debugPrint("contents of text file could not be loaded")
            }
        } else {
            debugPrint("text file not found")
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @objc func buttonPressed(sender: UIButton){
        // print("that was easy")
        (UIApplication.shared.delegate as! AppDelegate).levelStatus[((UIApplication.shared.delegate as! AppDelegate).currentLevel - 1)] = 2
        
        if ((UIApplication.shared.delegate as! AppDelegate).currentLevel != 20) {
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[(UIApplication.shared.delegate as! AppDelegate).currentLevel] = 1
        }
        
        self.levelRunner.map()
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

