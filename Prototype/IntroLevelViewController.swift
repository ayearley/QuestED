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
    var state = 0
    
    var nurseImage: UIImageView = UIImageView()
    var nurseLabel: UILabel = UILabel()
    
    init(runner: LevelRunner) {
        self.quiz = false;
        self.video = false;
        levelRunner = runner
        textFile = runner.levelText
        self.videoName = ""
        print("Text file: \(textFile)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.video = false;
        self.quiz = false;
        self.textFile = ""
        self.videoName = ""
        self.levelRunner = LevelRunner(textIn: self.textFile)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createDoctor()
        createNurse()
        
        readTextFile()
        
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
    
    func createNurse() {
        nurseImage = UIImageView(image: UIImage(imageLiteralResourceName: "horse.jpg"))
        nurseImage.frame = CGRect(x: Double(screenSize.width) * 0.8, y: Double(screenSize.height * 0.4), width: Double(screenSize.height) * 0.3, height: Double(screenSize.height) * 0.27)
        view.addSubview(nurseImage)
        nurseImage.isHidden = true
        
        nurseLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.5, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.26, height: Double(screenSize.height) * 0.24))
        nurseLabel.backgroundColor = UIColor.white
        view.addSubview(nurseLabel)
        nurseLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch state {
        case 0:
            doctorImage.isHidden = false
            doctorLabel.isHidden = false
        case 1:
            doctorImage.isHidden = true
            doctorLabel.isHidden = true
            nurseImage.isHidden = false
            nurseLabel.isHidden = false
        case 2:
            doctorImage.isHidden = false
            doctorLabel.isHidden = false
            nurseImage.isHidden = true
            nurseLabel.isHidden = true
        case 3:
            doctorImage.isHidden = true
            doctorLabel.isHidden = true
        case 4:
            view.addSubview(continueButton)
            
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
    }
    
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
