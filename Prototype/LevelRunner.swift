//
//  LevelRunner.swift
//  Prototype
//
//  Created by Jack Bloomfeld on 12/1/18.
//  Copyright © 2018 Jack Bloomfeld. All rights reserved.
//

import Foundation
import UIKit

class LevelRunner {
    
    //instantiated with a text file for intro, cadeuces, and game
    var levelText: String
    
    init(textIn: String){
        levelText = textIn
        
        print(levelText)
        
        runLevel()
    }
    
    func runLevel(){
    }
    
    func quiz(){
        //create the quiz view controller
        (UIApplication.shared.delegate as! AppDelegate).navController!.pushViewController(QuizViewController(runner: self), animated: true)
    }
    
    //create the introView
    func intro(){
        //Replace this with code that creates a screen instead of running self.navigationController?.pushViewController(IntroLevelViewController(), animated: true)
        (UIApplication.shared.delegate as! AppDelegate).navController!.pushViewController(IntroLevelViewController(runner: self), animated: true)

    }
    
    func cadeuces(){
        //create cadeuces view controller
        (UIApplication.shared.delegate as! AppDelegate).navController!.pushViewController(CadeucesViewController(runner: self), animated: true)
    }
    
    func game(){
        //create game view controller
        print("Level text: \(levelText)")
    }
    
    func map() {
        (UIApplication.shared.delegate as! AppDelegate).navController!.pushViewController(MapViewController(), animated: true)
    }
}
