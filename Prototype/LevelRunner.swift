//
//  LevelRunner.swift
//  Prototype
//
//  Created by Jack Bloomfeld on 12/1/18.
//  Copyright © 2018 Jack Bloomfeld. All rights reserved.
//

import Foundation

//instantiated with a text file for intro, cadeuces, and game
let String levelText;
//constructor
init(textIn: String){
    levelText = textIn;
    runLevel();
}

func runLevel(){
    while(levelQueue not emtpy){
        run next screen;
    }
}

//create the introView
func intro(){
   //Replace this with code that creates a screen instead of running self.navigationController?.pushViewController(IntroLevelViewController(), animated: true)
}

func cadeuces(){
    //create cadeuces view controller
}

func game(){
    //create game view controller
}
