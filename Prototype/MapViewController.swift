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
        
        
        let buttonLevel1 = UIButton(type: .custom)
        buttonLevel1.frame = CGRect(x: Double(screenSize.width)/7.35, y: Double(screenSize.height)/4.3, width: Double(buttonWidth), height: Double(buttonHeight))
        buttonLevel1.layer.cornerRadius = 0.5*buttonLevel1.bounds.size.width
        buttonLevel1.clipsToBounds = true
        buttonLevel1.setImage(UIImage(named:"easyButton.png"), for: .normal)
        buttonLevel1.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        view.addSubview(buttonLevel1)
        
        let buttonLevel2 = UIButton(type: .custom)
        buttonLevel2.frame = CGRect(x: Double(screenSize.width)/1.63, y: Double(screenSize.height)/2.48, width: Double(buttonWidth), height: Double(buttonHeight))
        buttonLevel2.layer.cornerRadius = 0.5*buttonLevel2.bounds.size.width
        buttonLevel2.clipsToBounds = true
        buttonLevel2.setImage(UIImage(named:"easyButton.png"), for: .normal)
        buttonLevel2.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        view.addSubview(buttonLevel2)
        
        let buttonLevel3 = UIButton(type: .custom)
        buttonLevel3.frame = CGRect(x: Double(screenSize.width)/4.42, y: Double(screenSize.height)/1.65, width: Double(buttonWidth), height: Double(buttonHeight))
        buttonLevel3.layer.cornerRadius = 0.5*buttonLevel3.bounds.size.width
        buttonLevel3.clipsToBounds = true
        buttonLevel3.setImage(UIImage(named:"easyButton.png"), for: .normal)
        buttonLevel3.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        view.addSubview(buttonLevel3)
        // Do any additional setup after loading the view.
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
    
    @objc func buttonPressed(){
        // print("that was easy")
        self.navigationController?.pushViewController(IntroLevelViewController(), animated: true)
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
