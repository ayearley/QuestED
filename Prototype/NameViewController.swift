//
//  NameViewController.swift
//  Prototype
//
//  Created by Jacob Zeitlin on 2/8/19.
//  Copyright © 2019 Alex Yearley. All rights reserved.
//

import UIKit
import AVKit

class NameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToNext(_ sender: Any) {
        submitName()
    }
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (UIApplication.shared.delegate as! AppDelegate).name = nameField.text!
        
        guard let path = Bundle.main.path(forResource: "Intro", ofType: "mp4") else {
            debugPrint("video.mp4 not found")
            return false
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true, completion: {
            player.play()
        })
        
        self.navigationController?.pushViewController(MapViewController(), animated: true)
        
        return false
    }*/
    
    func submitName() {
        (UIApplication.shared.delegate as! AppDelegate).name = nameField.text!
        
        guard let path = Bundle.main.path(forResource: "Intro", ofType: "mp4") else {
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
