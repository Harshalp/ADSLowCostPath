//
//  Cost.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/20/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//


//Class holds cost and path of the grid.

import UIKit

class Cost: Comparable {

    //Cost of the grid
    var gridCost = 0
    
    //Lowest total cost path to the grid
    var costPath = Array<Int>()
    
    //This will hold grid cost upto maximum cost
    var gridCostUptoMaximum = 0
    
    //Lowest traversed cost path to the grid. Holds path upto maximum cost.
    var costPathUptoMaximum = Array<Int>()
    
    //Holds weather whole path is traversed
    var traversedCompletePath = false
    
    //MARK:- Initialization with cost and row number
    init(cost: Int, gridRow:Int) {
        
        self.gridCost = cost
        self.costPath.append(gridRow)
    }
    
    //MARK:- Initialization with cost and array with lowest cost path traversed to reach this grid
    init(cost:Int, gridRows:Array<Int>) {
        
        self.gridCost = cost
        self.costPath.append(contentsOf: gridRows)        
    }
    
    // Returns a Boolean value indicating whether the value of the first
    // argument is less than that of the second argument.
    public static func <(lhs: Cost, rhs: Cost) -> Bool {
        
        return lhs.gridCost < rhs.gridCost
    }
    
    // Returns a Boolean value indicating whether the value of the first
    // argument is less than or equal to that of the second argument.
    public static func <=(lhs: Cost, rhs: Cost) -> Bool {
        
        return lhs.gridCost <= rhs.gridCost
    }
    
    // Returns a Boolean value indicating whether the value of the first
    // argument is greater than or equal to that of the second argument.
    public static func >=(lhs: Cost, rhs: Cost) -> Bool {
        
        return lhs.gridCost >= rhs.gridCost
    }
    
    // Returns a Boolean value indicating whether the value of the first
    // argument is greater than that of the second argument.
    public static func >(lhs: Cost, rhs: Cost) -> Bool {
        
        return lhs.gridCost > rhs.gridCost
    }
    
    // Returns a Boolean value indicating whether two values are equal.
    public static func ==(lhs: Cost, rhs: Cost) -> Bool {
     
        return lhs.gridCost == rhs.gridCost
    }
}
