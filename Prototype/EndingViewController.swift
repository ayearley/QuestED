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
    //var levelRunner: LevelRunner

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

        titleLabel.text = "Congratulations! You completed the game.YAY"
        titleLabel.textColor = UIColor.black
        view.addSubview(titleLabel)
        
        mapButton.setTitle("Back to Map", for: .normal)
        mapButton.addTarget(self, action: #selector(backToMap(selected:)), for:.touchUpInside)
        mapButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(mapButton)
    }
    
    @objc func backToMap(selected: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).navController!.pushViewController(MapViewController(), animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
