//
//  TextField.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/11.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit

class TextField: UITextField {

    var player:String?
    var activated:Bool! = false
    
    func settPlayer (_player:String){
        self.player = _player
        
        if activated == false{
            if _player == "x"{
                print("x")
            }else{
                print("o")
            }
            activated = true
        }
        
    }

}
