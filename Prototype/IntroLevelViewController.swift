//
//  IntroLevelViewController.swift
//  Prototype
//
//  Created by Alex Yearley on 12/1/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit

class IntroLevelViewController: UIViewController {

    @IBOutlet weak var introLabel: UILabel!
    
    let screenSize = UIScreen.main.bounds
    // let screenWidth = screenSize.width
    // let screenHeight = screenSize.height
    
    //Load all of these from file instead of hard coding
    var buttonWidth = 50;
    var buttonHeight = 50;
    
    var textFile: String
    var levelRunner: LevelRunner
    var quiz: Bool
    
    var doctorImage: UIImageView = UIImageView()
    var doctorLabel: UILabel = UILabel()
    var state = 0
    
    init(runner: LevelRunner) {
        self.quiz = false;
        levelRunner = runner
        textFile = runner.levelText
        print("Text file: \(textFile)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.quiz = false;
        self.textFile = ""
        self.levelRunner = LevelRunner(textIn: self.textFile)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createDoctor()
        
        readTextFile()
        
        let buttonLevel1 = UIButton(type: .custom)
        buttonLevel1.tag = 1
        buttonLevel1.frame = CGRect(x: Double(screenSize.width)/7.35, y: Double(screenSize.height)/4.3, width: Double(buttonWidth), height: Double(buttonHeight))
        buttonLevel1.layer.cornerRadius = 0.5*buttonLevel1.bounds.size.width
        buttonLevel1.clipsToBounds = true
        buttonLevel1.setImage(UIImage(named:"easyButton.png"), for: .normal)
        buttonLevel1.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        // view.addSubview(buttonLevel1)
        
        let continueButton = UIButton(type: .custom)
        continueButton.frame = CGRect(x: Double(screenSize.width) * 0.75, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10)
        continueButton.setImage(UIImage(named: "continue.png"), for: .normal)
        continueButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    @objc func buttonPressed(sender: UIButton){
        // print("that was easy")
        if(quiz){
            self.levelRunner.quiz()
        } else {
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[((UIApplication.shared.delegate as! AppDelegate).currentLevel - 1)] = 2
            if ((UIApplication.shared.delegate as! AppDelegate).currentLevel != 20) {
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[(UIApplication.shared.delegate as! AppDelegate).currentLevel] = 1
            }
            self.levelRunner.map()
        }
    }
    
    func createDoctor() {
        doctorImage = UIImageView(image: UIImage(imageLiteralResourceName: "doctor.png"))
        doctorImage.frame = CGRect(x: Double(screenSize.width) * 0.1, y: Double(screenSize.height * 0.4), width: Double(screenSize.height) * 0.2, height: Double(screenSize.height) * 0.27)
        view.addSubview(doctorImage)
        doctorImage.isHidden = true
        
        doctorLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.22, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.26, height: Double(screenSize.height) * 0.24))
        doctorLabel.backgroundColor = UIColor.white
        view.addSubview(doctorLabel)
        doctorLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch state {
        case 0:
            doctorImage.isHidden = false
            doctorLabel.isHidden = false
        case 1:
            doctorImage.isHidden = true
            doctorLabel.isHidden = true
        default:
            doctorImage.isHidden = doctorImage.isHidden
        }
        
        state += 1
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let introRange = contents.range(of: "*INTRO*:\n")
                let endRange = contents.range(of: "*END*")
                
                var introText = contents[introRange!.upperBound..<endRange!.lowerBound]
                if(introText.contains("*QUIZ*:")){
                    quiz = true;
                    let endRange = contents.range(of: "*QUIZ*:")
                    introText = contents[introRange!.upperBound..<endRange!.lowerBound]
                }
                
                print(introText)
                
                introLabel.text = String(introText)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
