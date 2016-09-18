//
//  GameScene.swift
//  SlitherSnakeTeamTart
//
//  Created by WangLiwei on 10/09/2016.
//  Copyright (c) 2016 Tart. All rights reserved.
//

import SpriteKit

struct PhisicsCategory {
    static let Player:UInt32 = 1
    static let Fruits:UInt32 = 2
}

//Add a node for the player's snake
var Player=SKSpriteNode(imageNamed:"Snake.png")
var Fruits=SKSpriteNode()
var Score = Int()
var ScoreLbl=UILabel()

var xVelocity: CGFloat = 0
var yVelocity: CGFloat = 0

//add SK physics contact delegate
class GameScene: SKScene, SKPhysicsContactDelegate{
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        //Setup score label
        ScoreLbl=UILabel(frame:CGRect(x:0,y:0,width: 100,height: 50))
        ScoreLbl.textColor=UIColor.whiteColor()
        ScoreLbl.backgroundColor=UIColor.grayColor()
        ScoreLbl.text="Score: "
        self.view?.addSubview(ScoreLbl)
        
        physicsWorld.contactDelegate=self
        
        //setup timer -- a fruit pops up
        let timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector:
            #selector(GameScene.FruitsPopup),userInfo: nil,repeats: true)
       
        Player.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.dynamic=true
        Player.physicsBody?.contactTestBitMask=PhisicsCategory.Fruits
        Player.physicsBody?.categoryBitMask=PhisicsCategory.Player
        
        self.addChild(Player)
    }
    
    func FruitsPopup(){
        //get ball's image randomly from the array
        let array=["apple.png","banana.png","strawberry.png","cherry.png"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        let Fruits=SKSpriteNode(imageNamed:array[randomIndex])
        
        //get balls at random position
        let MinValue=self.size.width/8
        let MaxValue=self.size.width-150
        let Point=UInt32(MaxValue-MinValue)
        Fruits.position=CGPoint(x:CGFloat(arc4random_uniform(Point)),y:(CGFloat(arc4random_uniform(Point))))
        
        Fruits.physicsBody=SKPhysicsBody(rectangleOfSize: Fruits.size)
        Fruits.physicsBody!.affectedByGravity = false
        Fruits.physicsBody?.dynamic=true
        Fruits.physicsBody?.collisionBitMask=PhisicsCategory.Player
        Fruits.physicsBody?.categoryBitMask=PhisicsCategory.Fruits
        self.addChild(Fruits)
    
    }
    
    //snake contacts with the ball(fruits)
    func didBeginContact(contact: SKPhysicsContact) {
        let firstbody:SKPhysicsBody=contact.bodyA
        let secondbody:SKPhysicsBody=contact.bodyB
        
        if((firstbody.categoryBitMask==PhisicsCategory.Player)&&(secondbody.categoryBitMask==PhisicsCategory.Fruits)){
            CollisionWithFruits(firstbody.node as! SKSpriteNode, Fruits: secondbody.node as!SKSpriteNode)
        }
    }
    
    
    func CollisionWithFruits(Player: SKSpriteNode,Fruits: SKSpriteNode){
        Score += 1
        ScoreLbl.text="Score: "+"\(Score)"
        
        Fruits.removeFromParent()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            if (location.x<self.size.width/2.0) {xVelocity = -100}
            else {xVelocity = 100}
            if (location.y<self.size.height/2.0) {yVelocity = -100}
            else {yVelocity = 100}
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        let rate: CGFloat = 0.01; //Controls rate of motion. 1.0 instantaneous, 0.0 none.
        let relativeVelocity: CGVector = CGVector(dx:xVelocity-Player.physicsBody!.velocity.dx, dy:yVelocity-Player.physicsBody!.velocity.dy);
        Player.physicsBody!.velocity=CGVector(dx:Player.physicsBody!.velocity.dx+relativeVelocity.dx*rate, dy:Player.physicsBody!.velocity.dy+relativeVelocity.dy*rate);
    }

}
