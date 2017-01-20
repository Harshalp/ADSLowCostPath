//
//  BestPath.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/18/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//


class BestPath {

    var totalCost: Int = 0
    var pathArray = Array<Int>()
    
    init(cost: Int, arrayElement:Int) {
        
        updatePath(cost: cost, arrayElement: arrayElement)
    }
    
    func updatePath(cost: Int, arrayElement:Int) {
     
        self.totalCost = cost
        self.pathArray.append(arrayElement)
    }
}
