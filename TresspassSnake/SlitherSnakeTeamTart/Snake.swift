//
//  Snake.swift
//  SlitherSnakeTeamTart
//
//  Created by WangLiwei on 10/09/2016.
//  Copyright © 2016 Tart. All rights reserved.
//

import Foundation

struct Position{
    var x:Int
    var y:Int
}

struct WorldSize{
    var width:Int
    var height:Int
}

//An enumeration defines a common type for a group of related values and enables you to work with those 
//values in a type-safe way within your code.
enum Directions{
    case East
    case South
    case West
    case North
    
    //move torwards the direction
    func move(point:Position, worldSize:WorldSize)->(Position){
        var positionX=point.x
        var positionY=point.y
        
        switch self{
        case East:
            positionX=worldSize.width+1
        case South:
            positionY=worldSize.height-1
        case West:
            positionX=worldSize.width-1
        case North:
            positionY=worldSize.height+1
        }
        return Position(x:positionX, y:positionY)
    }
}