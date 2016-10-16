//
//  EndScene.swift
//  SlitherSnakeTeamTart
//
//  Created by WangLiwei on 7/10/2016.
//  Copyright © 2016 Tart. All rights reserved.
//

import SpriteKit

var gameOverImage=SKSpriteNode(imageNamed:"gameover.png")

var gameoverlb = UILabel()

class EndScene: SKScene{
    override func didMove(to view: SKView) {
        //gameOverImage.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        //self.backgroundColor=UIColor.blackColor()
        gameoverlb=UILabel(frame:CGRect(x:50,y:50,width: 100,height: 50))
        gameoverlb.textColor=UIColor.white
        gameoverlb.backgroundColor=UIColor.yellow
        gameoverlb.text="Game Over!"
        self.view?.addSubview(ScoreLbl)
    }
}
