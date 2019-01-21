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
    var currentQuestion: Question!
    var selectedAns: Int
    var correctAns: Int
    var titleLabel: UILabel
    var an1Button: UIButton
    var an2Button: UIButton
    var an3Button: UIButton
    var submitButton: UIButton
    
    let screenSize = UIScreen.main.bounds
    let kVerticalSpacer: CGFloat = 16;
    let submit: String = "SUBMIT"
    
    init(runner: LevelRunner) {
        selectedAns = 0;
        currentQuestion = nil;
        correctAns = 0;
        levelRunner = runner
        textFile = runner.levelText
        titleLabel = UILabel()
        an1Button = UIButton()
        an2Button = UIButton()
        an3Button = UIButton()
        submitButton = UIButton()
        print("Text file: \(textFile)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        selectedAns = 0;
        currentQuestion = nil;
        correctAns = 0;
        self.textFile = ""
        self.levelRunner = LevelRunner(textIn: self.textFile)
        titleLabel = UILabel()
        an1Button = UIButton()
        an2Button = UIButton()
        an3Button = UIButton()
        submitButton = UIButton()
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        readTextFile()
        
        // set up the question title, choices and submit button
        titleLabel.text = currentQuestion.title;
        titleLabel.backgroundColor = UIColor.green
        view.addSubview(titleLabel)
        
        an1Button.setTitle(currentQuestion.choices[0], for: .normal)
        an1Button.backgroundColor = UIColor.red
        view.addSubview(an1Button)
        
        an2Button.setTitle(currentQuestion.choices[1], for: .normal)
        an2Button.backgroundColor = UIColor.red
        view.addSubview(an2Button)
        
        an3Button.setTitle(currentQuestion.choices[2], for: .normal)
        an3Button.backgroundColor = UIColor.red
        view.addSubview(an3Button)
        
        
        submitButton.setTitle(submit, for: .normal)
        submitButton.backgroundColor = UIColor.green
        view.addSubview(submitButton)

        
        //let image = UIImage(named: "no_image-128.png")
        //self.view.setBackgroundImage(image, for: UIControlState.normal)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "lightbg.png"))
        
//        let continueButton = UIButton(type: .custom)
//        continueButton.frame = CGRect(x: Double(screenSize.width) * 0.75, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10)
//        continueButton.setImage(UIImage(named: "continue.png"), for: .normal)
//        continueButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        view.addSubview(continueButton)
//        view.bringSubviewToFront(continueButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let centerHorizontal: CGFloat = screenSize.width / 2 -  screenSize.width / 6

        titleLabel.frame = CGRect(x: 16, y: 16, width: screenSize.width - 16 * 2, height: 80);
        
        an1Button.frame = CGRect(x: centerHorizontal, y: titleLabel.frame.maxY + kVerticalSpacer, width: screenSize.width / 3, height: 60);
        an2Button.frame = CGRect(x: centerHorizontal, y: an1Button.frame.maxY + kVerticalSpacer, width: screenSize.width / 3, height: 60);
        an3Button.frame = CGRect(x: centerHorizontal, y: an2Button.frame.maxY + kVerticalSpacer, width: screenSize.width / 3, height: 60);
        submitButton.frame = CGRect(x: Double(screenSize.width) * 0.75, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10);
        
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let quizRange = contents.range(of: "*QUIZ*:\n")
                let endQuizRange = contents.range(of: "*END*")
                
                let quizText = contents[quizRange!.upperBound..<endQuizRange!.lowerBound]
                
                let questionRange = contents.range(of: "q1:")
                let endQuestionRange = contents.range(of: "a1:")
                
                let questionText = contents[questionRange!.upperBound..<endQuestionRange!.lowerBound]
                
                let a1Range = contents.range(of: "a1:")
                let enda1Range = contents.range(of: "a2:")
                
                let a1Text = contents[a1Range!.upperBound..<enda1Range!.lowerBound]
                if(a1Text.contains("*")){
                    correctAns = 1;
                }
                
                let a2Range = contents.range(of: "a2:")
                let enda2Range = contents.range(of: "a3:")
                
                let a2Text = contents[a2Range!.upperBound..<enda2Range!.lowerBound]
                if(a2Text.contains("*")){
                    correctAns = 2;
                }
                
                let a3Range = contents.range(of: "a3:")
                let enda3Range = contents.range(of: "*END*")
                
                let a3Text = contents[a3Range!.upperBound..<enda3Range!.lowerBound]
                if(a3Text.contains("*")){
                    correctAns = 3;
                }
                
                currentQuestion = Question(title: String(questionText), choices: [String(a1Text), String(a2Text), String(a3Text)], correctAns: correctAns)
                
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

