//
//  LowCostFinder.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/23/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//

import UIKit

class LowCostFinder: NSObject {
    
    //Total number of rows and columns
    var rows: Int = 0
    var columns: Int = 0
    
    //It will hold the calculated cost for each row
    var additionColumn = Array<Cost>()
    
    //Maximum allowed cost. Path traversing should stop if cost exeeds 50.
    let maximumCost = 50

    //inputMatrix will hold the matrix enter by user
    var inputMatrix: [[Cost]] = []
    
    //MARK:- This will return the best path object which contains the minimum cost and path
    func findBestCostForMatrix(matrix: [[Cost]]) -> Cost {
        
        self.inputMatrix = matrix
        self.rows = self.inputMatrix.count
        self.columns = self.inputMatrix[0].count
        
        //Clear additionColumn array incase it has previously stored data
        self.additionColumn.removeAll()
        
        //Initialize additionColumn array with first column of matrix. This array will hold the additions of the costs from different columns along with the path.
        for i in 0..<self.rows {
            
            let cost = self.inputMatrix[i][0]
            self.additionColumn.append(cost)
        }
        
        if self.columns > 1 {
            
            //Below logic will add adjucent minimum cost number of particular column and store it into additionColumn array.
            for column in 1...self.columns-1 {
                
                //tempColumn will hold additions of two adjucent numbers temporarily.
                var tempColumn = Array<Cost>()
                
                for row in 0...self.rows-1 {
                    
                    var topAdjacent:Int
                    let middleAdjacent = row
                    var bottomAdjacent:Int
                    
                    if row == 0 {
                        
                        topAdjacent = self.rows-1
                    }
                    else {
                        topAdjacent = row-1
                    }
                    
                    if row == self.rows-1 {
                        
                        bottomAdjacent = 0
                    }
                    else {
                        bottomAdjacent = row+1
                    }
                    
                    //Get the minimum cost object
                    let minCost = minimumCost(adjacantRows: [topAdjacent, middleAdjacent, bottomAdjacent], matrixElement: self.inputMatrix[row][column])
                    
                    //If cost of the grid less than 50 and complete column is traversed then set traversedCompletePath.
                    if minCost.gridCost < self.maximumCost && column == self.columns-1 {
                        
                        minCost.traversedCompletePath = true
                    }
                    
                    tempColumn.append(minCost)
                }
                
                //If tempColumn doesn't contain anything then break the loop
                if tempColumn.count <= 0 { break }
                
                self.additionColumn.removeAll()
                self.additionColumn.append(contentsOf: tempColumn)
                tempColumn.removeAll()
            }
        }
        
        //Find minimum cost object in additionCost array
        var minCost:Cost!
        for row in 0...self.rows-1 {
            
            let additionCost = self.additionColumn[row]
            
            if minCost == nil {
                
                minCost = additionCost
            }
            else if minCost.gridCost > additionCost.gridCost {
                
                minCost = additionCost
            }
            
            if minCost.costPath.elementsEqual(minCost.costPathUptoMaximum) {
                
                minCost.traversedCompletePath = true
            }
        }
        
        return minCost
    }
    
    
    //MARK:- It will search and return minimum cost
    func minimumCost(adjacantRows: Array<Int>, matrixElement:Cost) -> Cost {
        
        //Calculate the cost of adjucant grids
        let topCost = self.additionColumn[adjacantRows[0]] as Cost
        let topAdjCostTotal = matrixElement.gridCost + topCost.gridCost
        
        let midCost = self.additionColumn[adjacantRows[1]] as Cost
        let midAdjCostTotal = matrixElement.gridCost + midCost.gridCost
        
        let btmCost = self.additionColumn[adjacantRows[2]] as Cost
        let btmAdjCostTotal = matrixElement.gridCost + btmCost.gridCost
        
        var cost:Cost
        
        //Cost comparison
        if topAdjCostTotal <= midAdjCostTotal  {
            
            if topAdjCostTotal <= btmAdjCostTotal {
                
                var pathArray = Array<Int>()
                pathArray.append(contentsOf: topCost.costPath)
                pathArray.append(adjacantRows[1]+1)
                
                //Create a Cost object with minimum cost and attach path traversed to reach it.
                cost = Cost(cost: topAdjCostTotal, gridRows:pathArray)
                
                if topAdjCostTotal < self.maximumCost {
                    
                    cost.costPathUptoMaximum.append(contentsOf: pathArray)
                    cost.gridCostUptoMaximum = topAdjCostTotal
                }
                else {
                    
                    cost.costPathUptoMaximum = topCost.costPathUptoMaximum
                    cost.gridCostUptoMaximum = topCost.gridCostUptoMaximum
                }
            }
            else {
                
                var pathArray = Array<Int>()
                pathArray.append(contentsOf: btmCost.costPath)
                pathArray.append(adjacantRows[1]+1)
                
                //Create a Cost object with minimum cost and attach path traversed to reach it.
                cost = Cost(cost: btmAdjCostTotal, gridRows: pathArray)
                
                if btmAdjCostTotal < self.maximumCost {
                    
                    cost.costPathUptoMaximum.append(contentsOf: pathArray)
                    cost.gridCostUptoMaximum = btmAdjCostTotal
                }
                else {
                    cost.costPathUptoMaximum = btmCost.costPathUptoMaximum
                    cost.gridCostUptoMaximum = btmCost.gridCostUptoMaximum
                }
            }
        }
        else {
            
            if midAdjCostTotal <= btmAdjCostTotal {
                
                var pathArray = Array<Int>()
                pathArray.append(contentsOf: midCost.costPath)
                pathArray.append(adjacantRows[1]+1)
                
                //Create a Cost object with minimum cost and attach path traversed to reach it.
                cost = Cost(cost: midAdjCostTotal, gridRows: pathArray)
                
                if midAdjCostTotal < self.maximumCost {
                    
                    cost.costPathUptoMaximum.append(contentsOf: pathArray)
                    cost.gridCostUptoMaximum = midAdjCostTotal
                }
                else {
                    cost.costPathUptoMaximum = midCost.costPathUptoMaximum
                    cost.gridCostUptoMaximum = midCost.gridCostUptoMaximum
                }
            }
            else {
                
                var pathArray = Array<Int>()
                pathArray.append(contentsOf: btmCost.costPath)
                pathArray.append(adjacantRows[1]+1)
                
                //Create a Cost object with minimum cost and attach path traversed to reach it.
                cost = Cost(cost: btmAdjCostTotal, gridRows: pathArray)
                
                if btmAdjCostTotal < self.maximumCost {
                    
                    cost.costPathUptoMaximum.append(contentsOf: pathArray)
                    cost.gridCostUptoMaximum = btmAdjCostTotal
                }
                else {
                    cost.costPathUptoMaximum = btmCost.costPathUptoMaximum
                    cost.gridCostUptoMaximum = btmCost.gridCostUptoMaximum
                }
            }
        }
        
        return cost
    }
}
