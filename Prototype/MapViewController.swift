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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("MapViewController", owner: self, options: nil)
        
        
        
        //Creates the level buttons for the map
        createButton(tag:1, widthRatio:1.75, heightRatio:2.5, completed:true)
        createButton(tag:2, widthRatio:1.88, heightRatio:1.9, completed:false)
        createButton(tag:3, widthRatio:2.05, heightRatio:1.65, completed:false)
        createButton(tag:4, widthRatio:2.28, heightRatio:1.45, completed:false)
        
        
        readTextFile();
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
        }
        buttonLevel.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        view.addSubview(buttonLevel)
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
        var levelRunner = LevelRunner(textIn: "level\(sender.tag)")
        levelRunner.intro()
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: "example", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let introRange = contents.range(of: "*INTRO*:\n")
                let cadeucesRange = contents.range(of: "*CADEUCES*:\n")
                
                let introText = contents[introRange!.upperBound..<cadeucesRange!.lowerBound]
                
                print(introText)
                
                // introLabel.text = String(introText)
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
