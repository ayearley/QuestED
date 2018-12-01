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
    
    //Load all of these from file instead of hard coding
    var buttonWidth = 50;
    var buttonHeight = 50;
    var level1x = 485;
    var level1y = 615;
    var level2x = 200;
    var level2y = 425;
    var level3x = 395;
    var level3y = 158;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("IntroMapController", owner: self, options: nil)
        
        let buttonLevel1 = UIButton(type: .custom)
        buttonLevel1.frame = CGRect(x: level1x, y: level1y, width: buttonWidth, height: buttonHeight)
        buttonLevel1.layer.cornerRadius = 0.5*buttonLevel1.bounds.size.width
        buttonLevel1.clipsToBounds = true
        buttonLevel1.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        view.addSubview(buttonLevel1)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonPressed(){
        print("that was easy")
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
