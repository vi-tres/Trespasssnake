//
//  TTTImageView.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/11.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit

class TTTImageView: UIViewController {

    var player:String?
    var activated:Bool! = false
    
    func settPlayer (_player:String){
        self.player = _player
        
        if activated == false{
            if _player == "x"{
                self.image = UIImage(named: "x")
            }else{
                self.image = UIImage(named: "o")
            }
            activated = true
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
