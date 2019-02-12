//
//  IntroLevelViewController.swift
//  Prototype
//
//  Created by Alex Yearley on 12/1/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit
import AVKit

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
    var video: Bool
    var quiz: Bool
    var videoName: String
    var continueButton: UIButton = UIButton(type: .custom)
    
    var doctorImage: UIImageView = UIImageView()
    var doctorLabel: UILabel = UILabel()
    var bubbleImage: UIImageView = UIImageView()
    var doctorLines: [String] = [String]()
    var totalDoctorLines = 0
    var currentLineD = 0
    
    var char1Name: String
    var char2Name: String

    var state = 0
    var nurseSpeaks: Bool = false
    
    var nurseImage: UIImageView = UIImageView()
    var nurseLabel: UILabel = UILabel()
    var nurseBubbleImage: UIImageView = UIImageView()
    var nurseLines: [String] = [String]()
    var totalNurseLines = 0
    var currentLineN = 0
    
    var introText: String
    var nurseText: String
    
    init(runner: LevelRunner) {
        self.quiz = false;
        self.video = false;
        levelRunner = runner
        textFile = runner.levelText
        self.videoName = ""
        print("Text file: \(textFile)")
        introText = ""
        nurseText = ""
        char1Name = ""
        char2Name = ""

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.video = false;
        self.quiz = false;
        self.textFile = ""
        self.videoName = ""
        self.levelRunner = LevelRunner(textIn: self.textFile)
        introText = ""
        nurseText = ""
        char1Name = ""
        char2Name = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        readTextFile()
        createDoctor()
        createNurse()
        
        
        continueButton.frame = CGRect(x: Double(screenSize.width) * 0.75, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10)
        continueButton.setImage(UIImage(named: "continue.png"), for: .normal)
        continueButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        //view.addSubview(continueButton)
    }
    
    @objc func buttonPressed(sender: UIButton){
        
        //plays video from level file
        if(videoName != "none"){
            guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
                debugPrint( "\(videoName).mp4 not found")
                return
            }
            
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerController = AVPlayerViewController()
            playerController.player = player
            present(playerController, animated: true, completion: {
                player.play()
            })
        }
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
        //if game reaches the end, launch ending screen
        
        if (levelRunner.levelText == "level14") {
            self.levelRunner.ending()
        }
    }
    
    func createDoctor() {
        print("character 1 from config file is" + char1Name)
        doctorImage = UIImageView(image: UIImage(imageLiteralResourceName: "" + char1Name + ".png"))
        //doctorImage = UIImageView(image: UIImage(imageLiteralResourceName: "doctor.png"))
        doctorImage.frame = CGRect(x: Double(screenSize.width) * 0.1, y: Double(screenSize.height * 0.2), width: Double(screenSize.height) * 0.2, height: Double(screenSize.height) * 0.27)
        view.addSubview(doctorImage)
        doctorImage.isHidden = true
        
        bubbleImage = UIImageView(image: UIImage(imageLiteralResourceName: "speechbubble_map.png"))
        
        doctorLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.24, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.50, height: Double(screenSize.height) * 0.24))
        bubbleImage.frame = CGRect(x: doctorLabel.frame.minX * 0.75, y: doctorLabel.frame.minY*0.7, width: doctorLabel.frame.width * 1.15, height: doctorLabel.frame.height * 2.0)
        
        view.addSubview(bubbleImage)
        bubbleImage.isHidden = true
        
        doctorLabel.backgroundColor = UIColor.clear
        doctorLabel.numberOfLines = 4
        doctorLabel.lineBreakMode = .byWordWrapping
        view.addSubview(doctorLabel)
        doctorLabel.isHidden = true
    }
    
    func createNurse() {
        nurseLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.5, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.26, height: Double(screenSize.height) * 0.24))
        nurseLabel.backgroundColor = UIColor.white
        view.addSubview(nurseLabel)
        nurseLabel.isHidden = true
        
        nurseImage = UIImageView(image: UIImage(imageLiteralResourceName: "nurse.png"))
        //should be replaced with the following once we have the corresponding character picture matching with the config file
        //nurseImage = UIImageView(image: UIImage(imageLiteralResourceName: "" + char2Name + ".png"))
        nurseImage.frame = CGRect(x: Double(screenSize.width) * 0.8, y: Double(screenSize.height * 0.2), width: Double(screenSize.height) * 0.2, height: Double(screenSize.height) * 0.27)
        view.addSubview(nurseImage)
        nurseImage.isHidden = true
        
        nurseBubbleImage = UIImageView(image: UIImage(imageLiteralResourceName: "speechbubble_large.png"))
        
        nurseLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.52, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.26, height: Double(screenSize.height) * 0.24))
        
        nurseBubbleImage.frame = CGRect(x: nurseLabel.frame.minX * 0.9, y: doctorLabel.frame.minY, width: doctorLabel.frame.width * 1.15, height: doctorLabel.frame.height)
        
        view.addSubview(nurseBubbleImage)
        nurseBubbleImage.isHidden = true
        
        nurseLabel.backgroundColor = UIColor.clear
        nurseLabel.numberOfLines = 4
        nurseLabel.lineBreakMode = .byWordWrapping
        view.addSubview(nurseLabel)
        nurseLabel.isHidden = true
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let startRange = contents.range(of: "*CHARACTER*:")
                //let doctorRange = contents.range(of: "doc: ")
                let endIntroRange = contents.range(of: "*END INTRO*")
                
                let finalEndRange = contents.range(of: "*END*")
                
                let quizText = String(contents[endIntroRange!.upperBound..<finalEndRange!.lowerBound])
                
                if(quizText.contains("*QUIZ*:")) {
                    quiz = true;
                } else {
                }
                
                // print("Pre: \(preIntroRange), end: \(endPreIntroRange)")
                
                introText = String(contents[startRange!.upperBound..<endIntroRange!.lowerBound])
                print(introText)
                
                
                let allCharsInfo = introText.split(separator: "\n")
                let char1Info = allCharsInfo[0]
                print(char1Info)
                char1Name = String(char1Info.split(separator: ":")[0])
                introText = String(char1Info.split(separator: ":")[1])
                
                //introText = String(contents[doctorRange!.upperBound..<endIntroRange!.lowerBound])
                
//                if (introText.contains("nurse: ")) {
//                    nurseSpeaks = true
//
//                    let nurseRange = contents.range(of: "nurse: ")
//                    //introText = String(contents[doctorRange!.upperBound..<nurseRange!.lowerBound])
//                    nurseText = String(contents[nurseRange!.upperBound..<endIntroRange!.lowerBound])
//                }
                
                if (allCharsInfo.count > 1) {
                    nurseSpeaks = true
                    let char2Info = allCharsInfo[1]
                    char2Name = String(char2Info.split(separator: ":")[0])
                    nurseText = String(char2Info.split(separator: ":")[1])
                }
                
                
                
                //loads video name
                let videoRange = contents.range(of: "*VIDEO*: ")
                let endVideoRange = contents.range(of: "*END*")
                
                videoName = String(contents[videoRange!.upperBound..<endVideoRange!.lowerBound])
                
                videoName = String(videoName.filter { !" \n".contains($0) })
                
            } catch {
                debugPrint("contents of text file could not be loaded")
            }
        } else {
            debugPrint("text file not found")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch state {
        case 0:
            print("Intro text: \(introText)")
            
            doctorLabel.text = introText
            
            doctorLines = getLinesArrayOfString(in: doctorLabel)
            
            totalDoctorLines = doctorLines.count
            
            
            if (doctorLines.count == 3) {
                doctorLabel.text = doctorLines[0] + doctorLines[1] + doctorLines[2]
            } else if (doctorLines.count == 2) {
                doctorLabel.text = doctorLines[0] + doctorLines[1]
            } else if (doctorLines.count == 1) {
                doctorLabel.text = doctorLines[0]
            } else {
                doctorLabel.text = doctorLines[0] + doctorLines[1] + doctorLines[2] + doctorLines[3]
            }
            
            doctorImage.isHidden = false
            doctorLabel.isHidden = false
            bubbleImage.isHidden = false
            
            state = 1
        case 1:
            currentLineD += 4
            
            
            if (currentLineD + 3 < totalDoctorLines) {
                var newText: String = ""
                
                for  i in currentLineD..<totalDoctorLines {
                    if (i <= currentLineD + 3) {
                        newText += doctorLines[i]
                    }
                }
                
                doctorLabel.text = newText
            } else {
                
                if (!nurseSpeaks) {
                    view.addSubview(continueButton)
                } else {
                    nurseLabel.text = nurseText
                    
                    nurseLines = getLinesArrayOfString(in: nurseLabel)
                    
                    totalNurseLines = nurseLines.count
                    
                    if (nurseLines.count == 3) {
                        nurseLabel.text = nurseLines[0] + nurseLines[1] + nurseLines[2]
                    } else if (nurseLines.count == 2) {
                        nurseLabel.text = nurseLines[0] + nurseLines[1]
                    } else if (nurseLines.count == 1) {
                        nurseLabel.text = nurseLines[0]
                    } else {
                        doctorLabel.text = nurseLines[0] + nurseLines[1] + nurseLines[2] + nurseLines[3]
                    }
                    
                    doctorImage.isHidden = true
                    doctorLabel.isHidden = true
                    bubbleImage.isHidden = true
                    nurseBubbleImage.isHidden = false
                    nurseImage.isHidden = false
                    nurseLabel.isHidden = false
                }
                
                state = 2
            }
            
        case 2:
            
            currentLineN += 4
            
            
            if (currentLineN + 3 < totalNurseLines) {
                var newText: String = ""
                
                for  i in currentLineN..<totalNurseLines {
                    if (i <= currentLineN + 3) {
                        newText += nurseLines[i]
                    }
                }
                
                nurseLabel.text = newText
            } else {
                
                if (nurseSpeaks) {
                    view.addSubview(continueButton)
                }
                
                state = 3
            }
            
            
        default:
            doctorImage.isHidden = doctorImage.isHidden
        }
    }
    
    /*func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let introRange = contents.range(of: "*INTRO*:\n")
                let endRange = contents.range(of: "*VIDEO*")
                
                var introText = contents[introRange!.upperBound..<endRange!.lowerBound]
                if(introText.contains("*QUIZ*:")){
                    quiz = true;
                    let endRange = contents.range(of: "*QUIZ*:")
                    introText = contents[introRange!.upperBound..<endRange!.lowerBound]
                }
     
                print(introText)
                
                introLabel.text = String(introText)
                
                let videoRange = contents.range(of: "*VIDEO*: ")
                let endVideoRange = contents.range(of: "*END*")
                
                videoName = String(contents[videoRange!.upperBound..<endVideoRange!.lowerBound])
                
                videoName = String(videoName.filter { !" \n".contains($0) })
                
                
                
            } catch {
                debugPrint("contents of text file could not be loaded")
            }
            
        } else {
            debugPrint("text file not found")
        }
    }*/
    
    func getLinesArrayOfString(in label: UILabel) -> [String] {
        
        /// An empty string's array
        var linesArray = [String]()
        
        guard let text = label.text, let font = label.font else {return linesArray}
        
        let rect = label.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
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
