//
//  IntroViewController.swift
//  Prototype
//
//  Created by Alex Yearley on 11/24/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit
import AVKit

class IntroViewController: UIViewController {
    
    //@IBOutlet weak var WelcomeLabel: UILabel!
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readLevelStatus()
        
        (UIApplication.shared.delegate as! AppDelegate).navController = self.navigationController
        
        Bundle.main.loadNibNamed("IntroViewController", owner: self, options: nil)
        //        self.WelcomeLabel.frame.origin.x = screenSize.width/2;
        //        self.WelcomeLabel.frame.origin.y = screenSize.height/2;
        //        self.WelcomeLabel.text = "Welcome to QuestED";
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "introbg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        // Do any additional setup after loading the view.
    }
    
    //Loads information from level file
    func readLevelStatus() {
        if let filepath = Bundle.main.path(forResource: "levelstatus", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                /*let introRange = contents.range(of: "*INTRO*:\n")
                 let cadeucesRange = contents.range(of: "*CADEUCES*:\n")
                 
                 let introText = contents[introRange!.upperBound..<cadeucesRange!.lowerBound]
                 
                 print(introText)
                 
                 // introLabel.text = String(introText)*/
                
                
                for status in contents {
                    let statusInt = Int(String(status))
                    
                    if (statusInt != nil) {
                        (UIApplication.shared.delegate as! AppDelegate).levelStatus.append(statusInt!)
                    }
                }
                
                for status in (UIApplication.shared.delegate as! AppDelegate).levelStatus {
                    print(status)
                }
            } catch {
                debugPrint("contents of text file could not be loaded")
            }
        } else {
            debugPrint("text file not found")
        }
    }
    
    @IBAction func toMap(_ sender: Any) {        
        self.navigationController?.pushViewController(NameViewController(), animated: true)
        
        readTextFile();
    }
    
    //loads in text from level file
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: "example", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let introRange = contents.range(of: "*INTRO*:\n")
                let cadeucesRange = contents.range(of: "*CADEUCES*:\n") //this probably needs to be changed
                
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
    
    func insertName(string: String) -> String {
        return string.replacingOccurrences(of: "(NAME)", with: (UIApplication.shared.delegate as! AppDelegate).name)
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
