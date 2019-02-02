//
//  MapViewController.swift
//  Prototype
//
//  Created by Alex Yearley on 11/24/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapImage: UIImageView!
    
    let screenSize = UIScreen.main.bounds
   // let screenWidth = screenSize.width
   // let screenHeight = screenSize.height
    
    //Load all of these from file instead of hard coding
    var buttonWidth = 50;
    var buttonHeight = 50;
    //var level1x = 45;
    //var level1y = 220;
    //var level2x = 245;
    //var level2y = 350;
    //var level3x = 120;
    //var level3y = 545;
    
    var doctorImage: UIImageView = UIImageView()
    var bubbleImage: UIImageView = UIImageView()
    var doctorLabel: UILabel = UILabel()
    var state = 0
    var preIntroText: String = ""
    var levelNumber = 0
    var totalLines = 0
    var currentLine = 0
    var lines: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("MapViewController", owner: self, options: nil)
        
        //Creates the level buttons for the map
        createButton(tag:1, widthRatio:1.75, heightRatio:2.5, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[0] == 1 || (UIApplication.shared.delegate as! AppDelegate).levelStatus[0] == 2)
        createButton(tag:2, widthRatio:1.88, heightRatio:1.9, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[1] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[1] == 2)
        createButton(tag:3, widthRatio:2.05, heightRatio:1.65, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[2] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[2] == 2)
        createButton(tag:4, widthRatio:2.28, heightRatio:1.45, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[3] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[3] == 2)
        
        createDoctor()
        
    }

    //This method creates a level button with the tag, x location, y location, and status as parameters
    func createButton(tag:Int, widthRatio:Double, heightRatio:Double, completed:Bool){
        let buttonLevel = UIButton(type: .custom)
        buttonLevel.tag = tag
        buttonLevel.frame = CGRect(x: Double(screenSize.width)/widthRatio, y: Double(screenSize.height)/heightRatio, width: Double(buttonWidth), height: Double(buttonHeight))
        buttonLevel.layer.cornerRadius = 0.5*buttonLevel.bounds.size.width
        buttonLevel.clipsToBounds = true
        if(completed){
            buttonLevel.setImage(UIImage(named:"easyButtonBlue.png"), for: .normal)
        } else {
            buttonLevel.setImage(UIImage(named:"easyButton.png"), for: .normal)
            buttonLevel.isEnabled = false;
        }
        buttonLevel.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        view.addSubview(buttonLevel)
    }
    
    func createDoctor() {
        doctorImage = UIImageView(image: UIImage(imageLiteralResourceName: "doctor.png"))
        doctorImage.frame = CGRect(x: Double(screenSize.width) * 0.1, y: Double(screenSize.height * 0.2), width: Double(screenSize.height) * 0.2, height: Double(screenSize.height) * 0.27)
        view.addSubview(doctorImage)
        doctorImage.isHidden = true
        
        bubbleImage = UIImageView(image: UIImage(imageLiteralResourceName: "speechbubble_map.png"))
        
        doctorLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.22, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.26, height: Double(screenSize.height) * 0.24))
        
        bubbleImage.frame = CGRect(x: doctorLabel.frame.minX * 0.9, y: doctorLabel.frame.minY, width: doctorLabel.frame.width * 1.15, height: doctorLabel.frame.height)
        
        view.addSubview(bubbleImage)
        bubbleImage.isHidden = true
        
        doctorLabel.backgroundColor = UIColor.clear
        doctorLabel.numberOfLines = 4
        doctorLabel.lineBreakMode = .byWordWrapping
        view.addSubview(doctorLabel)
        doctorLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {        
        if (state == 2) {
            currentLine += 4
            
            print("Total lines: \(totalLines)")
            
            if (currentLine + 3 < totalLines) {
                var newText: String = ""
                
                for  i in currentLine..<totalLines {
                    if (i <= currentLine + 3) {
                        newText += lines[i]
                    }
                }
                
                doctorLabel.text = newText
            } else {
                state = 3
            }
        }
        
        if (state == 3) {
            let levelRunner = LevelRunner(textIn: "level\(levelNumber)")
            levelRunner.intro()
        }
    }
    
    /*func addBackground() {
        // screen width and height:
        let width = screenSize.width
        let height = screenSize.height
        
        let imageViewBackground = UIImage(frame: CGRect(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "YOUR IMAGE NAME GOES HERE")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }*/
    
    @objc func buttonPressed(sender: UIButton){
        // print("that was easy")
        print(sender.tag)
        (UIApplication.shared.delegate as! AppDelegate).currentLevel = sender.tag
        
        state = 1
        
        // Disable all level buttons here
        
        if (state == 1) {
            levelNumber = sender.tag
            readTextFile()
            
            doctorImage.isHidden = false
            bubbleImage.isHidden = false
            doctorLabel.isHidden = false
            
            doctorLabel.text = preIntroText
            
            lines = getLinesArrayOfString(in: doctorLabel)
            
            totalLines = lines.count

            doctorLabel.text = lines[0] + lines[1] + lines[2] + lines[3]
            
            sender.isEnabled = false
            // Do the above line for other level buttons as well
            
            state = 2
        }
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: "level\(levelNumber)", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let preIntroRange = contents.range(of: "*PRE-INTRO*:\n")
                let endPreIntroRange = contents.range(of: "*INTRO*")
                
                // print("Pre: \(preIntroRange), end: \(endPreIntroRange)")
                
                preIntroText = String(contents[preIntroRange!.upperBound..<endPreIntroRange!.lowerBound])                
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
    
    func countLabelLines(label: UILabel) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = label.text! as NSString
        
        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
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
}

extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
