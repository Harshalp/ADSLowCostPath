//
//  Cost.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/20/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//


//Class holds cost and path of the grid.

import UIKit

class Cost: NSObject {

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
    
    //Maximum allowed cost. Path traversing should stop if cost exeeds 50.
    //let maximumCost = 50
    
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
}
