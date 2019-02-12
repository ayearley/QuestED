//
//  EndingViewController.swift
//  Prototype
//
//  Created by Zengying  You on 2/7/19.
//  Copyright © 2019 Alex Yearley. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {
    var titleLabel: UILabel
    var mapButton: UIButton
    let screenSize = UIScreen.main.bounds
    //var levelRunner: LevelRunner
    
    var doctorImage: UIImageView = UIImageView()
    var doctorLabel: UILabel = UILabel()
    var bubbleImage: UIImageView = UIImageView()
    var doctorLines: [String] = [String]()
    var totalDoctorLines = 0
    var currentLineD = 0

    init(runner: LevelRunner) {
        //levelRunner = runner
        titleLabel = UILabel()
        mapButton = UIButton()
        super.init(nibName: nil, bundle: nil)

    }
    required init?(coder aDecoder: NSCoder) {
        titleLabel = UILabel()
        mapButton = UIButton()
        //self.levelRunner = LevelRunner(textIn: self.textFile)

        super.init(coder: aDecoder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).navController = self.navigationController
        
        Bundle.main.loadNibNamed("EndingViewController", owner: self, options: nil)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "introbg.png")!)
        createDoctor()
        readTextFile()
        titleLabel.text = "Congratulations! You completed the game.YAY"
        titleLabel.textColor = UIColor.black
        view.addSubview(titleLabel)
        
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
        titleLabel.frame = CGRect(x: 280, y: 320, width: screenSize.width - 16 * 2, height: 80);
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
        
        doctorLabel = UILabel(frame: CGRect(x: Double(screenSize.width) * 0.22, y: Double(screenSize.height) * 0.26, width: Double(screenSize.width) * 0.26, height: Double(screenSize.height) * 0.24))
        
        bubbleImage.frame = CGRect(x: doctorLabel.frame.minX * 0.9, y: doctorLabel.frame.minY, width: doctorLabel.frame.width * 1.15, height: doctorLabel.frame.height)
        
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

}
