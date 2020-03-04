//
//  EndingViewController.swift
//  Prototype
//
//  Created by Zengying  You on 2/7/19.
//  Copyright © 2019 Alex Yearley. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {
    var mapButton: UIButton
    let screenSize = UIScreen.main.bounds
    //var levelRunner: LevelRunner
    
    var bgImage: UIImageView = UIImageView()
    
    var state = 0
    var levelNumber = 0
    var totalLines = 0
    var currentLine = 0
    var lines: [String] = [String]()
    var currentOffset = 0
    
    var doctorImage: UIImageView = UIImageView()
    var doctorLabel: UILabel = UILabel()
    var bubbleImage: UIImageView = UIImageView()
    var doctorLines: [String] = [String]()
    var totalDoctorLines = 0
    var currentLineD = 0

    init(runner: LevelRunner) {
        //levelRunner = runner
        mapButton = UIButton()
        super.init(nibName: nil, bundle: nil)

    }
    required init?(coder aDecoder: NSCoder) {
        mapButton = UIButton()
        //self.levelRunner = LevelRunner(textIn: self.textFile)

        super.init(coder: aDecoder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).navController = self.navigationController
        
        Bundle.main.loadNibNamed("EndingViewController", owner: self, options: nil)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "lightbg.png")!)
        
        var bgIm: UIImage = UIImage(named: "lightbg.png")!
        bgImage.image = bgIm
        view.addSubview(bgImage)
        createDoctor()
        readTextFile()
        
        //
        
        //
        
        mapButton.setTitle("Back to Map", for: .normal)
        mapButton.addTarget(self, action: #selector(backToMap(selected:)), for:.touchUpInside)
        mapButton.setTitleColor(UIColor.white, for: .normal)
        mapButton.backgroundColor = UIColor.black
        view.addSubview(mapButton)
    }
    
    @objc func backToMap(selected: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).navController!.pushViewController(MapViewController(offsetIn: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let screenSize = UIScreen.main.bounds
        mapButton.frame = CGRect(x: Double(screenSize.width) * 0.725, y: Double(screenSize.height) * 0.85, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10);
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: "ending", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                doctorLabel.text = contents
                
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
                
                // Do the above line for other level buttons as well
                
                state = 2
                
            } catch {
                debugPrint("contents of text file could not be loaded")
            }
        } else {
            debugPrint("text file not found")
        }
    }
    
    func createDoctor() {
        doctorImage = UIImageView(image: UIImage(imageLiteralResourceName: "doctor.png"))
        doctorImage.frame = CGRect(x: Double(screenSize.width) * 0.1, y: Double(screenSize.height * 0.2), width: Double(screenSize.height) * 0.2, height: Double(screenSize.height) * 0.27)
        view.addSubview(doctorImage)
        //doctorImage.isHidden = true
        
        bubbleImage = UIImageView(image: UIImage(imageLiteralResourceName: "speechbubble_map.png"))
        
        doctorLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.24, y: Double(screenSize.height) * 0.19, width: Double(screenSize.width) * 0.50, height: Double(screenSize.height) * 0.24))
         bubbleImage.frame = CGRect(x: doctorLabel.frame.minX * 0.75, y: doctorLabel.frame.minY*0.7, width: doctorLabel.frame.width * 1.15, height: doctorLabel.frame.height * 1.5)
        
        view.addSubview(bubbleImage)
        //bubbleImage.isHidden = true
        
        doctorLabel.backgroundColor = UIColor.clear
        doctorLabel.numberOfLines = 4
        doctorLabel.lineBreakMode = .byWordWrapping
        view.addSubview(doctorLabel)
        //doctorLabel.isHidden = true
    
    
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
    
    func insertName(string: String) -> String {
        return string.replacingOccurrences(of: "(NAME)", with: (UIApplication.shared.delegate as! AppDelegate).name)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (state == 2) {
            currentLine += 4
            
            print("Total lines: \(totalLines)")
            
            if (currentLine + 1 < totalLines) {
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
            
        }
    }

}
/*
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
    
} */


