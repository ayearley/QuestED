//
//  CadeucesViewController.swift
//  Prototype
//
//  Created by Jacob Zeitlin on 12/8/18.
//  Copyright © 2018 Alex Yearley. All rights reserved.
//

import UIKit

class CadeucesViewController: UIViewController {

    var textFile: String
    var levelRunner: LevelRunner
    
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var cadeucesLabel: UILabel!
    
    init(runner: LevelRunner) {
        levelRunner = runner
        textFile = runner.levelText
        print("Text file: \(textFile)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.textFile = ""
        self.levelRunner = LevelRunner(textIn: self.textFile)
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        readTextFile()
        
        let continueButton = UIButton(type: .custom)
        continueButton.frame = CGRect(x: Double(screenSize.width) * 0.75, y: Double(screenSize.height) * 0.75, width: Double(screenSize.height) / 3, height: Double(screenSize.height) / 10)
        continueButton.setImage(UIImage(named: "continue.png"), for: .normal)
        continueButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    func readTextFile() {
        if let filepath = Bundle.main.path(forResource: textFile, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                let cadeucesRange = contents.range(of: "*CADEUCES*:\n")
                let endRange = contents.range(of: "*END*")
                
                let cadeucesText = contents[cadeucesRange!.upperBound..<endRange!.lowerBound]
                
                print(cadeucesText)
                
                cadeucesLabel.text = String(cadeucesText)
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
