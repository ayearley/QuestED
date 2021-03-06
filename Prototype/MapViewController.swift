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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var contentView: UIView = UIView()
    
    @IBOutlet weak var testbutton: UIButton!
    
    let screenSize = UIScreen.main.bounds
    // let screenWidth = screenSize.width
    // let screenHeight = screenSize.height
    
    //Load all of these from file instead of hard coding
    var buttonWidth = 150;
    var buttonHeight = 150;
    
    var doctorImage: UIImageView = UIImageView()
    var bubbleImage: UIImageView = UIImageView()
    var doctorLabel: UILabel = UILabel()
    var state = 0
    var preIntroText: String = ""
    var levelNumber = 0
    var totalLines = 0
    var currentLine = 0
    var lines: [String] = [String]()
    var currentOffset = 0
    
    init(offsetIn: Int){
        currentOffset = offsetIn
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("MapViewController", owner: self, options: nil)
        
        testbutton.setImage(UIImage(named:"easyButtonBlue.png"), for: .normal)
        scrollView.contentSize = CGSize(width: screenSize.width, height: screenSize.width*3.05)
        scrollView.contentOffset = CGPoint(x: 0, y: currentOffset)
        var mapIm: UIImage = UIImage(named: "map1.png")!
        mapImage.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.width * 3.08)
        mapImage.image = mapIm
        contentView.frame = mapImage.frame
        contentView.addSubview(mapImage)
        
        //Creates the level buttons for the map
        createButton(tag:1, widthRatio:0.3613, heightRatio:0.9642, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[0] == 1 || (UIApplication.shared.delegate as! AppDelegate).levelStatus[0] == 2)
        createButton(tag:2, widthRatio:0.6162, heightRatio:0.9333, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[1] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[1] == 2)
        createButton(tag:3, widthRatio:0.7933, heightRatio:0.8788, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[2] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[2] == 2)
        createButton(tag:4, widthRatio:0.6305, heightRatio:0.8225, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[3] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[3] == 2)
        createButton(tag:5, widthRatio:0.3834, heightRatio:0.7690, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[4] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[4] == 2)
        createButton(tag:6, widthRatio:0.5844, heightRatio:0.6853, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[5] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[5] == 2)
        createButton(tag:7, widthRatio:0.8033, heightRatio:0.6430, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[6] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[6] == 2)
        createButton(tag:8, widthRatio:0.5841, heightRatio:0.6008, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[7] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[7] == 2)
        createButton(tag:9, widthRatio:0.3613, heightRatio:0.377, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[8] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[8] == 2)
        createButton(tag:10, widthRatio:0.5453, heightRatio:0.3016, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[9] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[9] == 2)
        createButton(tag:11, widthRatio:0.7878, heightRatio:0.2789, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[10] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[10] == 2)
        createButton(tag:12, widthRatio:0.5180, heightRatio:0.2382, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[11] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[11] == 2)
        createButton(tag:13, widthRatio:0.2913, heightRatio:0.2063, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[12] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[12] == 2)
        createButton(tag:14, widthRatio:0.3868, heightRatio:0.1446, completed:
            (UIApplication.shared.delegate as! AppDelegate).levelStatus[13] == 1 ||
                (UIApplication.shared.delegate as! AppDelegate).levelStatus[13] == 2)
        
        createDoctor()
        scrollView.addSubview(contentView)
        
    }
    
    //This method creates a level button with the tag, x location, y location, and status as parameters
    func createButton(tag:Int, widthRatio:Double, heightRatio:Double, completed:Bool){
        let buttonLevel = UIButton(type: .custom)
        buttonLevel.tag = tag
        buttonLevel.frame.size = CGSize(width: Double(buttonWidth), height: Double(buttonHeight))
        buttonLevel.center = CGPoint(x: Double(screenSize.width)*widthRatio, y: Double(contentView.frame.height)*heightRatio)
        buttonLevel.layer.cornerRadius = 0.5*buttonLevel.bounds.size.width
        buttonLevel.clipsToBounds = true
        print("Completed: \(completed)")

        if(completed){
            buttonLevel.setImage(UIImage(named:"level\(tag)blue1.png"), for: .normal)
            //buttonLevel.layer.borderWidth = 1
            //buttonLevel.layer.borderColor = UIColor.yellow.cgColor
        } else {
            buttonLevel.setImage(UIImage(named:"level\(tag)red1.png"), for: .normal)
            buttonLevel.isEnabled = false; //comment this out to access all levels
        }
        
        buttonLevel.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        contentView.addSubview(buttonLevel)
        buttonLevel.backgroundColor = UIColor.clear
    }
    
    func createDoctor() {
        doctorImage = UIImageView(image: UIImage(imageLiteralResourceName: "doctor.png"))
        doctorImage.frame = CGRect(x: Double(screenSize.width) * 0.1, y: Double(screenSize.height * 0.2), width: Double(screenSize.height) * 0.2, height: Double(screenSize.height) * 0.27)
        view.addSubview(doctorImage)
        doctorImage.isHidden = true
        
        bubbleImage = UIImageView(image: UIImage(imageLiteralResourceName: "speechbubble_map.png"))
        
        doctorLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.22, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.35, height: Double(screenSize.height) * 0.24))
        
        bubbleImage.frame = CGRect(x: doctorLabel.frame.minX * 0.85, y: doctorLabel.frame.minY, width: doctorLabel.frame.width * 1.13, height: doctorLabel.frame.height)
        
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
            
            print("Current line: \(currentLine)")
            
            if (currentLine < totalLines) {
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
            let levelRunner = LevelRunner(textIn: "level\(levelNumber)", offsetIn: Int(scrollView.contentOffset.y))
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
        
        scrollView.isUserInteractionEnabled = false
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
            
            var i: Int = 0
            
            totalLines = lines.count
            
            for j in i..<totalLines {
                print("Line \(j): \(lines[j])")
            }
            
            if (lines.count == 3) {
                doctorLabel.text = lines[0] + lines[1] + lines[2]
            } else if (lines.count == 2) {
                doctorLabel.text = lines[0] + lines[1]
            } else if (lines.count == 1) {
                doctorLabel.text = lines[0]
            } else {
                doctorLabel.text = lines[0] + lines[1] + lines[2] + lines[3]
            }
            
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
                preIntroText = insertName(string: preIntroText)
                preIntroText = preIntroText.trimmingCharacters(in: .whitespacesAndNewlines)
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
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width * 0.90, height: 100000), transform: .identity)
        
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
    
    func insertName(string: String) -> String {
        return string.replacingOccurrences(of: "(NAME)", with: (UIApplication.shared.delegate as! AppDelegate).name)
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
