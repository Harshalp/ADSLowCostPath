//
//  Matrix.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/18/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//


//The class with hold input matrix entered by user and operations on that matrix

import Foundation

class Matrix {
    
    //inputMatrix will hold the matrix enter by user
    var inputMatrix: [[Cost]] = []
    
    //Total number of rows and columns
    var rows: Int
    var columns: Int
    
    //It will hold the calculated cost for each row
    var additionColumn = Array<Cost>()
    
    //Maximum allowed cost. Path traversing should stop if cost exeeds 50.
    let maximumCost = 50
    
    
    //MARK:- Initialization
    init?(input : String) {
        
        //Validates blank input
        if input == "" {
            return nil
        }
    
        //Calculate number of rows and columns
        let rowArray = input.components(separatedBy: "\n")
        self.rows = rowArray.count
        var columnArray = rowArray[0].components(separatedBy: ",")
        self.columns = columnArray.count
        
        //Initialize input matrix
        self.inputMatrix = Array(repeating: Array(repeating: Cost(cost: Int(0), gridRow: 0), count: self.columns), count: self.rows)
        
        //Fill the input matrix with input data
        for i in 0..<self.rows {
            
            columnArray = rowArray[i].components(separatedBy: ",")
            
            //Condition to check all the rows contains same number of columns
            if columnArray.count != self.columns {
                
                return nil
            }
            
            for j in 0..<self.columns {
                
                //This will check whether input contains only integer value
                if let value = Int(columnArray[j].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) {
                
                    let cost = Cost(cost: value, gridRow: i+1)
                
                    if value < maximumCost {
                        cost.gridCostUptoMaximum = value
                        cost.costPathUptoMaximum.append(i+1)
                    }
                    self.inputMatrix[i][j] = cost
                }
                else {
                    
                    return nil
                }
            }
        }
    }
    
    //MARK:- This will return the best path object which contains the minimum cost and path
    func findBestCost() -> Cost {
        
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
        
        let topCost = self.additionColumn[adjacantRows[0]] as Cost
        let topAdjCostTotal = matrixElement.gridCost + topCost.gridCost
        
        let midCost = self.additionColumn[adjacantRows[1]] as Cost
        let midAdjCostTotal = matrixElement.gridCost + midCost.gridCost
        
        let btmCost = self.additionColumn[adjacantRows[2]] as Cost
        let btmAdjCostTotal = matrixElement.gridCost + btmCost.gridCost
        
        var cost:Cost
        
        if topAdjCostTotal <= midAdjCostTotal  {
            
            if topAdjCostTotal <= btmAdjCostTotal {
                
                var pathArray = Array<Int>()
                pathArray.append(contentsOf: topCost.costPath)
                pathArray.append(adjacantRows[1]+1)
                
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
