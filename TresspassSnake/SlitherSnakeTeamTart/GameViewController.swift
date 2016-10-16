//
//  GameViewController.swift
//  SlitherSnakeTeamTart
//
//  Created by WangLiwei on 10/09/2016.
//  Copyright (c) 2016 Tart. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var PlayerName = ""
    var SnakeColor: UIColor!
    

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
     
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            skView.allowsTransparency = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.playername = PlayerName
            //scene.snakecolor = Variables.coinsVariable
            scene.backgroundColor = UIColor.green
            
            skView.presentScene(scene)
            
            
        }    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
