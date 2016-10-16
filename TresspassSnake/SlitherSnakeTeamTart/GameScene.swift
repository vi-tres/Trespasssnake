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
var Player: Array<SKShapeNode>=[]

var Score = Int()
var ScoreLbl=UILabel()

var PlayerLabel=UILabel()

let DarkenOpacity: CGFloat = 0.8
var mydir:CGPoint = CGPoint(x:1,y:0)
var adir:Array<CGPoint>! = []

@available(iOS 9.0, *)
var theCamera: SKCameraNode = SKCameraNode()
var count:Int = 0
var xVelocity: CGFloat = 0
var yVelocity: CGFloat = 0

//add SK physics contact delegate
class GameScene: SKScene, SKPhysicsContactDelegate{
    var mine:Array<SKShapeNode>!
    var fruits:Array<SKShapeNode>!=[]
    var fruit :SKShapeNode!
    var returnFruits :SKShapeNode!
    var enemys:Array<Array<SKShapeNode>>!=[]
    var enemy:Array<SKShapeNode>!
    var playername = " "
    var snakecolor = MyVariables.color
    
    var darkenLayer: SKSpriteNode?
    var gameOverLabel: SKLabelNode?
    var playernameLabel: SKLabelNode?
    var playerscoreLabel: SKLabelNode?
    var gameOver = false
    var gameOverElapsed: CFTimeInterval = 0

    override func didMove(to view: SKView) {
        /* Setup your scene here */
        print("snakecolor")
        print("playername")
        print(playername)
        if #available(iOS 9.0, *) {
            self.camera=theCamera
        } else {
            // Fallback on earlier versions
        }
        //Setup score label
        ScoreLbl=UILabel(frame:CGRect(x:100,y:0,width: 100,height: 50))
        ScoreLbl.textColor=UIColor.white
        ScoreLbl.backgroundColor=UIColor.gray
        ScoreLbl.text="Score: 0"
        self.view?.addSubview(ScoreLbl)
        
        //Setup playername label
        PlayerLabel=UILabel(frame:CGRect(x:0,y:0,width: 100,height: 50))
        PlayerLabel.textColor=UIColor.white
        PlayerLabel.backgroundColor=UIColor.gray
        PlayerLabel.text = playername
        PlayerLabel.textAlignment = NSTextAlignment.center
        self.view?.addSubview(PlayerLabel)

        
        mine = createSnake(CGPoint(x: self.frame.midX, y: self.frame.midY), dir: mydir)

        physicsWorld.contactDelegate=self
        
        for i: Int in (1 ..< 100)
        {
            fruit = fruitsPopup(CGPoint(x: CGFloat(arc4random()%1000)+self.frame.midX, y: self.frame.midY+CGFloat(arc4random()%1000)))
            fruits.append(fruit)
        }
        
        //setup timer -- a fruit pops up
        let timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector:
            #selector(GameScene.fruitsPopup),userInfo: nil,repeats: true)
        
        print(fruits.count)
        for i: Int in (1 ..< 20)
        {
            var adir1 = CGPoint.init(x: 1, y: 0)
            adir1.x = (CGFloat(arc4random()%1000))/500-1;
            adir1.y = pow(-1, CGFloat(arc4random()))*sqrt(1-pow(adir1.x, 2))
            enemy = creatEnemySnake(CGPoint(x: CGFloat(arc4random()%1000)+self.frame.midX, y: self.frame.midY+CGFloat(arc4random()%1000)), dir:adir1)
            enemys.append(enemy)
            adir.append(adir1)
        }
        
        //set initial camera start position
        if #available(iOS 9.0, *) {
            theCamera.position = CGPoint(x: self.mine[0].position.x - self.frame.midX/2, y: self.mine[0].position.y)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func createSnake(_ posi: CGPoint, dir :CGPoint)->Array<SKShapeNode>
    {
        //snake initialise
        if(MyVariables.mode == 1){
       let head = SKShapeNode.init(circleOfRadius: 10)
        let eye1 = SKShapeNode.init(circleOfRadius: 3)
            let eye2 = SKShapeNode.init(circleOfRadius: 3)
        //let head = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        
        print("CREATSNAKE")
        head.fillColor=snakecolor
        head.addChild(eye1)
        head.addChild(eye2)
        eye1.position = CGPoint.init(x: eye1.parent!.position.x+10, y: eye1.parent!.position.y+5)
        eye1.fillColor = UIColor.black
        eye2.position = CGPoint.init(x: eye2.parent!.position.x+10, y: eye2.parent!.position.y-5)
        eye2.fillColor = UIColor.black
        head.position = posi;
        self.addChild(head)
        Player.append(head)
        head.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        
        if(dir.x>0)
        {
            let action = SKAction.rotate(toAngle: atan(dir.y/dir.x), duration: 0);
            head.run(action)
        }else
        {
            let action = SKAction.rotate(toAngle: atan(dir.y/dir.x)+3.14159, duration: 0);
            head.run(action)
        }
        print("CREATSNAKEColor")
        print("SNAKECOLOR")
        for i:Int in (1 ..< 5)
        {
            let a = SKShapeNode.init(circleOfRadius: 10);
            a.position = CGPoint(x: head.position.x+(CGFloat(i)*dir.x*10), y:head.position.y+(CGFloat(i)*dir.y*10))
            
            a.fillColor = UIColor(
                red: MyVariables.red,
                green: MyVariables.green,
                blue: MyVariables.blue,
                alpha: 1.0)

            self.addChild(a)
            Player.append(a)
            }}
        else{
            let head = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
            let eye1 = SKShapeNode.init(circleOfRadius: 3)
            let eye2 = SKShapeNode.init(circleOfRadius: 3)
            //let head = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
            
            print("CREATSNAKE")
            head.fillColor=snakecolor
            head.addChild(eye1)
            head.addChild(eye2)
            eye1.position = CGPoint.init(x: eye1.parent!.position.x+10, y: eye1.parent!.position.y+5)
            eye1.fillColor = UIColor.black
            eye2.position = CGPoint.init(x: eye2.parent!.position.x+10, y: eye2.parent!.position.y-5)
            eye2.fillColor = UIColor.black
            head.position = posi;
            self.addChild(head)
            Player.append(head)
            head.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
            
            if(dir.x>0)
            {
                let action = SKAction.rotate(toAngle: atan(dir.y/dir.x), duration: 0);
                head.run(action)
            }else
            {
                let action = SKAction.rotate(toAngle: atan(dir.y/dir.x)+3.14159, duration: 0);
                head.run(action)
            }
            print("CREATSNAKEColor")
            print("SNAKECOLOR")
            for i:Int in (1 ..< 5)
            {
                let a = SKShapeNode(rectOf: CGSize(width: 20, height: 20));
                a.position = CGPoint(x: head.position.x+(CGFloat(i)*dir.x*10), y:head.position.y+(CGFloat(i)*dir.y*10))
                
                a.fillColor = UIColor(
                    red: MyVariables.red,
                    green: MyVariables.green,
                    blue: MyVariables.blue,
                    alpha: 1.0)
                
                self.addChild(a)
                Player.append(a)
            }}

        return Player
    }
    
    //create enemys' snake
    func creatEnemySnake (_ posi: CGPoint, dir :CGPoint)-> Array<SKShapeNode>
    {
        var snake: Array<SKShapeNode>=[]
        let head = SKShapeNode.init(circleOfRadius: 10)
        let eye1 = SKShapeNode.init(circleOfRadius: 3)
        let eye2 = SKShapeNode.init(circleOfRadius: 3)
        head.fillColor=UIColor.gray
        head.addChild(eye1)
        head.addChild(eye2)
        eye1.position = CGPoint.init(x: eye1.parent!.position.x+10, y: eye1.parent!.position.y+5)
        eye1.fillColor = UIColor.black
        eye2.position = CGPoint.init(x: eye2.parent!.position.x+10, y: eye2.parent!.position.y-5)
        eye2.fillColor = UIColor.black
        head.position = posi;
        self.addChild(head)
        snake.append(head)
        if(dir.x>0)
        {
            let action = SKAction.rotate(toAngle: atan(dir.y/dir.x), duration: 0);
            head.run(action)
        }else
        {
            let action = SKAction.rotate(toAngle: atan(dir.y/dir.x)+3.14159, duration: 0);
            head.run(action)
        }
        for i:Int in (1 ..< 5)
        {
            let a = SKShapeNode.init(circleOfRadius: 10);
            a.position = CGPoint(x: head.position.x+(CGFloat(i)*dir.x*10), y:head.position.y+(CGFloat(i)*dir.y*10))
            a.fillColor = UIColor.gray
            self.addChild(a)
            snake.append(a)
        }
        //self.addChild(head)
        return snake
        
    }
    
    func fruitsPopup(_ posi:CGPoint)->SKShapeNode{
        //get ball's image randomly from the array
        //let array=["apple.png","banana.png","strawberry.png","cherry.png"]
        let randomIndex = CGFloat(arc4random_uniform(UInt32(10-3)))
        let fruit = SKShapeNode.init(circleOfRadius: randomIndex)
        fruit.position = posi
        fruit.fillColor = UIColor.yellow
        self.addChild(fruit)
        //get balls at random position
        let MinValue=self.size.width/8
        let MaxValue=self.size.width-150
        let Point=UInt32(MaxValue-MinValue)
        fruit.position=CGPoint(x:CGFloat(arc4random_uniform(Point)),y:(CGFloat(arc4random_uniform(Point))))

        return fruit
    }
    
    //Snake moves follow the screen touch direction
    func snakeMove(_ Player : Array<SKShapeNode>, dir: CGPoint)
    {
        //print(Player.endIndex)
        for i in ((0 + 1)...Player.endIndex-1).reversed()
        {
            Player[i].position=Player[i-1].position;
            //print(i)
        }
        Player[0].position = CGPoint (x:Player[0].position.x+dir.x*10, y:Player[0].position.y+dir.y*10)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchposition = touch.location(in: self)
            let distance = sqrt(pow(touchposition.x-mine[0].position.x, 2)+pow(touchposition.y-mine[0].position.y, 2))
            mydir = CGPoint(x: ((touchposition.x-mine[0].position.x)/distance), y: (touchposition.y-mine[0].position.y)/distance)
            //print(mydir)
            if (mydir.x>0)
            {
                let action = SKAction.rotate(toAngle: atan(mydir.y/mydir.x), duration: 0)
                self.mine[0].run(action)
            }else
            {
                let action = SKAction.rotate(toAngle: atan(mydir.y/mydir.x)+3.14159, duration: 0)
                self.mine[0].run(action)
            }
        }
    }
    
    //SnakeDie
    func snakeDie (_ she:Array<SKShapeNode>, othershes:Array<Array<SKShapeNode>>)->Bool
    {
        var status:Bool = false
        for othershe:Array<SKShapeNode> in othershes
        {
            for part:SKShapeNode in othershe
            {
                if (sqrt(pow(she[0].position.x-part.position.x, 2)+pow(she[0].position.y-part.position.y, 2))<10)
                {
                    status = true
                    //self.view?.presentScene(EndScene())
                }
            }
        }
        return status
    }
    
    //snake eats fruits
    func eatFruits(_ Player:Array<SKShapeNode>, fruits:Array<SKShapeNode>) -> Array<SKShapeNode>{
        var fruitsReturn = fruits
        let headposition:CGPoint = Player[0].position
        for fruit:SKShapeNode in fruits
        {
            if (sqrt(pow(headposition.x-fruit.position.x, 2)+pow(headposition.y-fruit.position.y
                , 2))<20)
            {
                fruitsReturn.remove(at: fruits.index(of: fruit)!)
                fruit.removeFromParent()
                
                //Score += 1
                //ScoreLbl.text="Score: "+"\(Score)"
            }
        }
        return fruitsReturn
    }
    
    //snake extends length
    func extendLength(_ Player:Array<SKShapeNode>) -> Array<SKShapeNode> {
        var player = Player
        if(MyVariables.mode == 1){let a = SKShapeNode.init(circleOfRadius: 10);
        a.fillColor=UIColor(
            red: MyVariables.red,
            green: MyVariables.green,
            blue: MyVariables.blue,
            alpha: 1.0)

        a.position = CGPoint(x: 2*player[player.endIndex-1].position.x-player[player.endIndex-2].position.x, y:2*player[player.endIndex-1].position.y-player[player.endIndex-2].position.y)
        self.addChild(a)
            player.append(a)}
        else{let a = SKShapeNode(rectOf: CGSize(width: 20, height: 20));
            a.fillColor=UIColor(
                red: MyVariables.red,
                green: MyVariables.green,
                blue: MyVariables.blue,
                alpha: 1.0)
            
            a.position = CGPoint(x: 2*player[player.endIndex-1].position.x-player[player.endIndex-2].position.x, y:2*player[player.endIndex-1].position.y-player[player.endIndex-2].position.y)
            self.addChild(a)
            player.append(a)}
        return player
    }
    
    //Update
    override func update(_ currentTime: TimeInterval) {
        if #available(iOS 9.0, *) {
            //print(theCamera.position)
        } else {
            // Fallback on earlier versions
        }
       // print(self.mine[0].position)
        self.snakeMove(self.mine, dir:mydir)

        for i:Int in (0 ..< self.enemys.count)
        {
            if (count % 10 == 0)
            {
                
                let x1:CGFloat = (CGFloat(arc4random()%1000))/500.0-1.0;
                let y1:CGFloat = pow(-1, CGFloat(arc4random()))*sqrt(1-pow(x1, 2))
                adir[i] = CGPoint.init(x: x1, y: y1)
            }
            enemy = self.enemys[i]
            if(adir[i].x>0)
            {
                let action = SKAction.rotate(toAngle: atan(adir[i].y/adir[i].x), duration: 0);
                enemy[0].run(action)
            }else
            {
                let action = SKAction.rotate(toAngle: atan(adir[i].y/adir[i].x)+3.14159, duration: 0);
                enemy[0].run(action)
            }
            self.snakeMove(enemy, dir: adir[i])
            let fruitLength = Score
            fruits = self.eatFruits(enemy, fruits: fruits)
            /*if(self.eatFruits(self.mine: , fruits: fruits)==true){
                Score += 1
                ScoreLbl.text="Score: "+"\(Score)"
                
            }*/
            let pScore = Score
            
            if ((!(fruitLength == pScore)))
            {
                enemy = self.extendLength(enemy)
                self.enemys[i] = enemy
            }
            
        }
        var otherPlayers = enemys
       // otherPlayers.append(self.mine)
        otherPlayers!.append(self.mine)
        for i:Int in (0 ..< (otherPlayers?.count)!-1)
        {
            var otherSnakes = otherPlayers
            for j:Int in (0 ..< (otherSnakes?.count)!)
            {
                if((otherPlayers?[i])!==(otherSnakes?[j])!)
                {
                    //otherSnakes.remove(at: j)
                    otherSnakes!.remove(at: j)
                    break
                }
            }
            if(self.snakeDie((otherPlayers?[i])!, othershes: otherSnakes!))
            {
                for t:Int in (0 ..< enemys[i].count)
                {
                    enemys[i][t].removeFromParent();
                    returnFruits = fruitsPopup(CGPoint(x: CGFloat(arc4random()%1000)+enemys[i][t].position.x, y: enemys[i][t].position.y+CGFloat(arc4random()%1000)))
                    
                    fruits.append(returnFruits)
                    
                }
                enemys.remove(at: i)
                adir.remove(at: i)
            }
            
        }
        
        let fruitLength = fruits.count
        fruits = self.eatFruits(self.mine, fruits: fruits)
        let fruitLength1 = fruits.count
        
        if ((!(fruitLength==fruitLength1)))
        {
            //User score+1
            Score+=1
            ScoreLbl.text="Score: "+"\(Score)"
            
            self.mine = self.extendLength(self.mine)
        }
        //reset camera position
        if #available(iOS 9.0, *) {
            theCamera.position=self.mine[0].position
        } else {
            // Fallback on earlier versions
        }
        
        //if user die, jump to game end scene
        if(snakeDie(self.mine, othershes: enemys))
        {
            if((self.mine) != nil){
            
            gameOver = true
            gameOverElapsed = 0
            
            gameOverLabel = SKLabelNode(fontNamed: "Helvetica")
            gameOverLabel?.text = "Game Over!"
            gameOverLabel?.fontSize = 44
            gameOverLabel?.position = self.mine[0].position
                
            addChild(gameOverLabel!)
           
                print("GAMEOVER Self")}
            else{
                print("lalal")
            }
        }
        count = count + 1
        if(count == 10)
        {
            count = 0
        }
        
        usleep(100000)
    }

}
