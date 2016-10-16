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
    case east
    case south
    case west
    case north
    
    //move torwards the direction
    func move(_ point:Position, worldSize:WorldSize)->(Position){
        var positionX=point.x
        var positionY=point.y
        
        switch self{
        case .east:
            positionX=worldSize.width+1
        case .south:
            positionY=worldSize.height-1
        case .west:
            positionX=worldSize.width-1
        case .north:
            positionY=worldSize.height+1
        }
        return Position(x:positionX, y:positionY)
    }
}
