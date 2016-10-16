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
//var deltaPoint = CGPointZero
var deltaPoint = CGPoint()
//var bgImage = SKSpriteNode(imageNamed: "wallpaper.png")
//var myLabel:SKLabelNode!


class EndScene: SKScene{
    override func didMove(to view: SKView) {

        
        //gameOverImage.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        //self.backgroundColor=UIColor.blackColor()
        
        print("ENDSCENE")
        //gameoverlb=UILabel(frame:CGRect(x:50,y:50,width: 100,height: 50))
        //gameoverlb.textColor=UIColor.white
        //gameoverlb.backgroundColor=UIColor.yellow
        //gameoverlb.text="Game Over!"
        //self.view?.addSubview(ScoreLbl)
        
        //bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        print("GAMEOVERLABEL")
        //myLabel.fontColor = UIColor.red
       // myLabel.fontColor = UIColor(red: CGFloat(1.0), green: CGFloat(0.0), blue: CGFloat(0.0), alpha: CGFloat(1.0))
        let myLabel = SKLabelNode(fontNamed: "Arial")
        print("myLabel")
        myLabel.fontColor = UIColor(red: CGFloat(1.0), green: CGFloat(0.0), blue: CGFloat(0.0), alpha: CGFloat(1.0))
        myLabel.text = "Drag this label"
        myLabel.fontSize = 20
        print("myLabelposition")
        myLabel.horizontalAlignmentMode = .center
        myLabel.verticalAlignmentMode = .center
        print("myLabelpositionend")
        //x: CGFloat, y: CGFloat
        self.addChild(myLabel)
    }
}
