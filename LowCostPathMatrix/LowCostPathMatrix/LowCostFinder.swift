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
    
    
    //Mark:- Initialize additionColumns array
    func initializeArrays(matrix:[[Cost]]) {
        
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
    }
    
    
    //MARK:- This will return the best path object which contains the minimum cost and path
    func findBestCostFor(matrix: [[Cost]]) -> Cost {
        
        initializeArrays(matrix: matrix)
        
        if self.columns > 1 {
            
            //Below logic will add adjucent minimum cost number of particular column and store it into additionColumn array.
            for column in 1...self.columns-1 {
                
                //tempColumn will hold additions of two adjucent numbers temporarily.
                var tempColumn = Array<Cost>()
                
                for row in 0...self.rows-1 {
                    
                    let currentCost = self.inputMatrix[row][column]
                    
                    //Get the adjacent rows
                    let (topAdjacent,bottomAdjacent) = getAdjacentRows(row: row, totalRows: self.rows)
                    
                    //Get the minimum cost grid adjacent to current grid
                    let minCost = min(self.additionColumn[topAdjacent],self.additionColumn[row],self.additionColumn[bottomAdjacent])
                    
                    let totalMinValue = minCost.gridCost + currentCost.gridCost
                    
                    var pathArray = Array<Int>()
                    pathArray.append(contentsOf: minCost.costPath)
                    pathArray.append(row+1)
                    
                    //Create a Cost object with minimum cost and attach path traversed to reach it.
                    let totalCost = Cost(cost: totalMinValue, gridRows:pathArray)
                    
                    if totalMinValue < self.maximumCost {
                        
                        totalCost.costPathUptoMaximum.append(contentsOf: pathArray)
                        totalCost.gridCostUptoMaximum = totalMinValue
                    }
                    else {
                        
                        totalCost.costPathUptoMaximum = minCost.costPathUptoMaximum
                        totalCost.gridCostUptoMaximum = minCost.gridCostUptoMaximum
                    }
                    
                    tempColumn.append(totalCost)
                }
                
                //If tempColumn doesn't contain anything then break the loop and do not update the additionColumn
                if tempColumn.count <= 0 { break }
                
                self.additionColumn.removeAll()
                self.additionColumn.append(contentsOf: tempColumn)
                tempColumn.removeAll()
            }
        }
        
        //Get the minimum cost from additionColumn
        let minCost = searchLowCostIn(costs: additionColumn)
        
        return minCost
    }
    
    
    //Mark:- Searchs for lowest cost from the provided costs
    func searchLowCostIn(costs: [Cost]) -> Cost {
        
        //Find minimum cost object in additionCost array
        var minCost:Cost!
        
        for additionCost in costs {
            
            if minCost == nil {
                
                minCost = additionCost
            }
            else if minCost > additionCost {
                
                minCost = additionCost
            }
            
            if minCost.costPath.elementsEqual(minCost.costPathUptoMaximum) {
                
                minCost.traversedCompletePath = true
            }
        }
        
        return minCost
    }
    
    
    //Mark:- It calculates and returns the adjucent rows to provided row
    func getAdjacentRows(row:Int, totalRows:Int) -> (Int, Int) {
        
        var topAdjacent:Int
        var bottomAdjacent:Int
        
        //Calculate top and bottom rows
        if row == 0 {
            
            topAdjacent = totalRows-1
        }
        else {
            topAdjacent = row-1
        }
        
        if row == totalRows-1 {
            
            bottomAdjacent = 0
        }
        else {
            bottomAdjacent = row+1
        }
        
        return (topAdjacent, bottomAdjacent)
    }
}
