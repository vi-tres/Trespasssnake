//
//  GameOver.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/16.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit
import SpriteKit

class GameOver: SKScene {
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        print("GAMEOVER")
        gameoverlb=UILabel(frame:CGRect(x:50,y:50,width: 100,height: 50))
        gameoverlb.textColor=UIColor.white
        gameoverlb.backgroundColor=UIColor.yellow
        gameoverlb.text="Game Over!"
        self.view?.addSubview(ScoreLbl)
    }

}
