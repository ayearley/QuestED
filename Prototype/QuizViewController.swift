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
    
    //stores each question object
    var question1: Question!
    var question2: Question!
    var question3: Question!
    
    //stores the current selected answer
    var selectedAns: UIButton!
    
    //stores correct answer for each question
    var q1Ans: Int
    var q2Ans: Int
    var q3Ans: Int
    var correctAns: Int
    var titleLabel: UILabel
    var an1Button: UIButton
    var an2Button: UIButton
    var an3Button: UIButton
    var submitButton: UIButton
    var nextButton: UIButton
    var wrongButton: UIButton
    var currentQuestion: Int
    var progress: UIImageView
    
    let screenSize = UIScreen.main.bounds
    let kVerticalSpacer: CGFloat = 16;
    let submit: String = "SUBMIT"
    
    //initializes private variables
    init(runner: LevelRunner) {
        selectedAns = nil;
        currentQuestion = 1;
        question1 = nil;
        question2 = nil;
        question3 = nil;
        q1Ans = -1;
        q2Ans = -1;
        q3Ans = -1;
        correctAns = -1; //set to -1 to tell if correctAns is not populated correctly
        levelRunner = runner
        textFile = runner.levelText
        titleLabel = UILabel()
        an1Button = UIButton()
        an2Button = UIButton()
        an3Button = UIButton()
        submitButton = UIButton()
        nextButton = UIButton()
        wrongButton = UIButton()
        progress = UIImageView()
        print("Text file: \(textFile)")
        super.init(nibName: nil, bundle: nil)
    }
    
    //initializes private variables
    required init?(coder aDecoder: NSCoder) {
        selectedAns = nil;
        currentQuestion = 1;
        question1 = nil;
        question2 = nil;
        question3 = nil;
        q1Ans = -1;
        q2Ans = -1;
        q3Ans = -1;
        correctAns = -1;
        self.textFile = ""
        self.levelRunner = LevelRunner(textIn: self.textFile, offsetIn: 0)
        titleLabel = UILabel()
        an1Button = UIButton()
        an2Button = UIButton()
        an3Button = UIButton()
        submitButton = UIButton()
        nextButton = UIButton()
        wrongButton = UIButton()
        progress = UIImageView()
        super.init(coder: aDecoder)
    }
    
    //automatically loads question 1 onto the screen from the question1 object
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestion = 1
        
        // Do any additional setup after loading the view.
        readTextFile()
        
        // set up the progress bar, question title, choices and submit button
        progress.image = UIImage(named: "progress-bar.png")
        view.addSubview(progress)

        titleLabel.text = question1.title;
        //titleLabel.backgroundColor = UIColor.green
        view.addSubview(titleLabel)
        
        an1Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an1Button.setTitle(question1.choices[0], for: .normal)
        an1Button.setTitleColor(UIColor.black, for: .normal)
        an1Button.tag = 1
        an1Button.titleLabel?.numberOfLines = 0
        an1Button.titleLabel?.textAlignment = .center
        an1Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an1Button)
        
        an2Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an2Button.setTitle(question1.choices[1], for: .normal)
        an2Button.setTitleColor(UIColor.black, for: .normal)
        an2Button.titleLabel?.numberOfLines = 0
        an2Button.titleLabel?.textAlignment = .center
        an2Button.tag = 2
        an2Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an2Button)
        
        an3Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an3Button.setTitle(question1.choices[2], for: .normal)
        an3Button.setTitleColor(UIColor.black, for: .normal)
        an3Button.titleLabel?.numberOfLines = 0
        an3Button.titleLabel?.textAlignment = .center
        an3Button.tag = 3
        an3Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an3Button)
        
        
        submitButton.setImage(UIImage(named:"check.png"), for: .normal)
        submitButton.addTarget(self, action: #selector(submitAns(selected:)), for:.touchUpInside)
        view.addSubview(submitButton)

        correctAns = q1Ans
        
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
    
    
    //method that loads question 2 screen from the question2 object
    func loadQuestion2(){
        super.viewDidLoad()
        
        currentQuestion = 2
        // Do any additional setup after loading the view.
        readTextFile()
        
        // set up the question title, choices and submit button
        progress.image = UIImage(named: "progress-bar-1_3.png")

        titleLabel.text = question2.title;
        //titleLabel.backgroundColor = UIColor.green
        
        view.addSubview(titleLabel)
        
        an1Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an1Button.setTitle(question2.choices[0], for: .normal)
        an1Button.setTitleColor(UIColor.black, for: .normal)
        an1Button.tag = 1
        an1Button.titleLabel?.numberOfLines = 0
        an1Button.titleLabel?.textAlignment = .center
        an1Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an1Button)
        
        an2Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an2Button.setTitle(question2.choices[1], for: .normal)
        an2Button.setTitleColor(UIColor.black, for: .normal)
        an2Button.tag = 2
        an2Button.titleLabel?.numberOfLines = 0
        an2Button.titleLabel?.textAlignment = .center
        an2Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an2Button)
        
        an3Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an3Button.setTitle(question2.choices[2], for: .normal)
        an3Button.setTitleColor(UIColor.black, for: .normal)
        an3Button.tag = 3
        an3Button.titleLabel?.numberOfLines = 0
        an3Button.titleLabel?.textAlignment = .center
        an3Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an3Button)
        
        
        submitButton.setImage(UIImage(named:"check.png"), for: .normal)
        submitButton.addTarget(self, action: #selector(submitAns(selected:)), for:.touchUpInside)
        view.addSubview(submitButton)
        nextButton.isHidden = true
        submitButton.isHidden = false
        wrongButton.isHidden = true
        correctAns = q2Ans
    }
    
    
    //method that loads question 3 screen from the question3 object
    func loadQuestion3(){
        super.viewDidLoad()
        
        currentQuestion = 3
        
        // Do any additional setup after loading the view.
        readTextFile()
        
        // set up the question title, choices and submit button
        progress.image = UIImage(named: "progress-bar-2_3.png")
        titleLabel.text = question3.title;
        //titleLabel.backgroundColor = UIColor.green
        
        view.addSubview(titleLabel)
        
        an1Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an1Button.setTitle(question3.choices[0], for: .normal)
        an1Button.setTitleColor(UIColor.black, for: .normal)
        an1Button.tag = 1
        an1Button.titleLabel?.numberOfLines = 0
        an1Button.titleLabel?.textAlignment = .center
        an1Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an1Button)
        
        an2Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an2Button.setTitle(question3.choices[1], for: .normal)
        an2Button.setTitleColor(UIColor.black, for: .normal)
        an2Button.tag = 2
        an2Button.titleLabel?.numberOfLines = 0
        an2Button.titleLabel?.textAlignment = .center
        an2Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an2Button)
        
        an3Button.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        an3Button.setTitle(question3.choices[2], for: .normal)
        an3Button.setTitleColor(UIColor.black, for: .normal)
        an3Button.tag = 3
        an3Button.titleLabel?.numberOfLines = 0
        an3Button.titleLabel?.textAlignment = .center
        an3Button.addTarget(self, action: #selector(setSelectedAns(selected:)), for:.touchUpInside)
        view.addSubview(an3Button)
        
        
        submitButton.setImage(UIImage(named:"check.png"), for: .normal)
        submitButton.addTarget(self, action: #selector(submitAns(selected:)), for:.touchUpInside)
        view.addSubview(submitButton)
        nextButton.isHidden = true
        submitButton.isHidden = false
        wrongButton.isHidden = true
        correctAns = q3Ans
    }
    
    //if submit btn is clicked
    @objc func submitAns(selected: UIButton) {
        if (selectedAns == nil) {
            let alert = UIAlertController(title: "",message: "Nothing is selected. Please select!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true, completion: nil)

            print("Nothing is selected. Please select!")
        } else if (correctAns == selectedAns.tag) {
            //change color to green and pops up next button
            selectedAns.setBackgroundImage(UIImage(named: "choice-right.png"), for: .normal)
            submitButton.isHidden = true
            nextButton.isHidden = false
            nextButton.setImage(UIImage(named: "next.png"), for: .normal)
            nextButton.addTarget(self, action: #selector(toNextQuestion), for:.touchUpInside)
            view.addSubview(nextButton)
            print("correct")
        } else {
            print("wrong-o")
            //change color to red and redo
            selectedAns.setBackgroundImage(UIImage(named: "choice-wrong.png"), for: .normal)
            wrongButton.isHidden = false
            wrongButton.setImage(UIImage(named: "wrong.png"), for: .normal)
            view.addSubview(wrongButton)
        }
    }
    
    @objc func clearWrongAns(alert: UIAlertAction) {
        //clear current selection
        selectedAns.backgroundColor = UIColor.gray
        selectedAns = nil
    }
    
    @objc func toNextQuestion() {
        if(currentQuestion == 1){
            loadQuestion2()
        }
        else if(currentQuestion == 2){
            loadQuestion3()
        }
        else if(currentQuestion == 3){
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[((UIApplication.shared.delegate as! AppDelegate).currentLevel - 1)] = 2
            
            if ((UIApplication.shared.delegate as! AppDelegate).currentLevel != 20) {
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[(UIApplication.shared.delegate as! AppDelegate).currentLevel] = 1
            }
            let alert = UIAlertController(title: "", message: "Yay. You successfully passed the quiz!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return to map.", style: .default, handler: {action in self.levelRunner.map()}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //to set the selected ans idx to the one chosen
    @objc func setSelectedAns(selected: UIButton) {
        wrongButton.isHidden = true
        submitButton.isHidden = false
        if(selectedAns != nil){
            selectedAns.setBackgroundImage(UIImage(named: "choice-untapped.png"), for: .normal)
        }
        selectedAns = selected
        selectedAns.setBackgroundImage(UIImage(named: "choice-tapped.png"), for: .normal)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let centerHorizontal: CGFloat = screenSize.width / 2 -  screenSize.width / 6
        progress.frame = CGRect(x: 8, y: 8, width: screenSize.width - 16 * 2, height: 30);
        titleLabel.frame = CGRect(x: 16, y: 40, width: screenSize.width - 16 * 2, height: 50);
        let margin: CGFloat = 8.0
        let buttonWidth = screenSize.width - margin * 2
        an1Button.frame = CGRect(x: margin, y: titleLabel.frame.maxY + kVerticalSpacer, width: buttonWidth, height: an1Button.titleLabel?.sizeThatFits(screenSize.size).height ?? 20)
        an2Button.frame = CGRect(x: margin, y: an1Button.frame.maxY + kVerticalSpacer, width: buttonWidth, height: an2Button.titleLabel?.sizeThatFits(screenSize.size).height ?? 20);
        an3Button.frame = CGRect(x: margin, y: an2Button.frame.maxY + kVerticalSpacer, width: buttonWidth, height: an3Button.titleLabel?.sizeThatFits(screenSize.size).height ?? 20);
        submitButton.frame = CGRect(x: Double(screenSize.width) * 0.825, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10);
        nextButton.frame = CGRect(x: Double(screenSize.width) * 0.825, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10);
        wrongButton.frame = CGRect(x: Double(screenSize.width) * 0.825, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10);
    }
    
  
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                //This was my attempt to make a loop that keeps loading question in a loop
                /*
                do {
                    // Read an entire text file into an NSString.
                    let contents = try NSString(contentsOfFile: filepath,
                                                encoding: String.Encoding.ascii.rawValue)
                    
                    //array of question objects
                    Question[] qarray
                    
                    //current question being built
                    var buildingQ: Question
                    
                    // Print all lines.
                    contents.enumerateLines({ (line, stop) -> () in
                        if line.contains("q:"){
                            buildingQ = new Question(title: line)
                        }
                        if(line.contains("a:"))
                        print("Line = \(line)")
                    })
                } */
                
                //Goes through the text file and creates 3 question objects
                let questionRange = contents.range(of: "q1:")
                let endQuestionRange = contents.range(of: "a1:")
                
                let questionText = contents[questionRange!.upperBound..<endQuestionRange!.lowerBound]
                
                let a1Range = contents.range(of: "a1:")
                let enda1Range = contents.range(of: "a2:")
                
                var a1Text = String(contents[a1Range!.upperBound..<enda1Range!.lowerBound])
                print(a1Text)
                if(a1Text.contains("*")){
                    a1Text = a1Text.replacingOccurrences(of: "*", with: "")
                    q1Ans = 1;
                }
                
                let a2Range = contents.range(of: "a2:")
                let enda2Range = contents.range(of: "a3:")
                
                var a2Text = String(contents[a2Range!.upperBound..<enda2Range!.lowerBound])
                print(a2Text)
                if(a2Text.contains("*")){
                    a2Text = a2Text.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q1Ans = 2;
                }
                
                let a3Range = contents.range(of: "a3:")
                let enda3Range = contents.range(of: "q2:")
                
                var a3Text = String(contents[a3Range!.upperBound..<enda3Range!.lowerBound])
                print(a3Text)
                if(a3Text.contains("*")){
                    a3Text = a3Text.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q1Ans = 3;
                }
                
                question1 = Question(title: String(questionText), choices: [String(a1Text), String(a2Text), String(a3Text)], correctAns: q1Ans)
                
                //question 2 building
                let questionRange2 = contents.range(of: "q2:")
                let endQuestionRange2 = contents.range(of: "a12:")
                
                let questionText2 = contents[questionRange2!.upperBound..<endQuestionRange2!.lowerBound]
                
                let a1Range2 = contents.range(of: "a12:")
                let enda1Range2 = contents.range(of: "a22:")
                
                var a1Text2 = String(contents[a1Range2!.upperBound..<enda1Range2!.lowerBound])
                if(a1Text2.contains("*")){
                    a1Text2 = a1Text2.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q2Ans = 1;
                }
                
                let a2Range2 = contents.range(of: "a22:")
                let enda2Range2 = contents.range(of: "a32:")
                
                var a2Text2 = String(contents[a2Range2!.upperBound..<enda2Range2!.lowerBound])
                if(a2Text2.contains("*")){
                    a2Text2 = a2Text2.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q2Ans = 2;
                }
                
                let a3Range2 = contents.range(of: "a32:")
                let enda3Range2 = contents.range(of: "q3:")
                
                var a3Text2 = String(contents[a3Range2!.upperBound..<enda3Range2!.lowerBound])
                if(a3Text2.contains("*")){
                    a3Text2 = a3Text2.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q2Ans = 3;
                }
                
                question2 = Question(title: String(questionText2), choices: [String(a1Text2), String(a2Text2), String(a3Text2)], correctAns: q2Ans)
                
                //question 3 building
                let questionRange3 = contents.range(of: "q3:")
                let endQuestionRange3 = contents.range(of: "a13:")
                
                let questionText3 = contents[questionRange3!.upperBound..<endQuestionRange3!.lowerBound]
                
                let a1Range3 = contents.range(of: "a13:")
                let enda1Range3 = contents.range(of: "a23:")
                
                var a1Text3 = String(contents[a1Range3!.upperBound..<enda1Range3!.lowerBound])
                if(a1Text3.contains("*")){
                    a1Text3 = a1Text3.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q3Ans = 1;
                }
                
                let a2Range3 = contents.range(of: "a23:")
                let enda2Range3 = contents.range(of: "a33:")
                
                var a2Text3 = String(contents[a2Range3!.upperBound..<enda2Range3!.lowerBound])
                if(a2Text3.contains("*")){
                    a2Text3 = a2Text3.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q3Ans = 2;
                }
                
                let a3Range3 = contents.range(of: "a33:")
                let enda3Range3 = contents.range(of: "*VIDEO*")
                
                var a3Text3 = String(contents[a3Range3!.upperBound..<enda3Range3!.lowerBound])
                if(a3Text3.contains("*")){
                    a3Text3 = a3Text3.replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil)
                    q3Ans = 3;
                }
                a3Text3 = a3Text3.trimmingCharacters(in: .whitespacesAndNewlines)

                question3 = Question(title: String(questionText3), choices: [String(a1Text3), String(a2Text3), String(a3Text3)], correctAns: q3Ans)
                
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

