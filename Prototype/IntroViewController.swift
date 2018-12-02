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

    @IBOutlet weak var WelcomeLabel: UILabel!
    
     let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
           Bundle.main.loadNibNamed("IntroViewController", owner: self, options: nil)
        self.WelcomeLabel.frame.origin.x = screenSize.width/2;
        self.WelcomeLabel.frame.origin.y = screenSize.height/2;
        self.WelcomeLabel.text = "Welcome to QuestED";
        // Do any additional setup after loading the view.
    }

    @IBAction func toMap(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "QuestED Video", ofType: "mov") else {
            debugPrint("video.mp4 not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true, completion: {
            player.play()
        })
        
        self.navigationController?.pushViewController(MapViewController(), animated: true)
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
