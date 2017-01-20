//
//  Matrix.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/18/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//

import Foundation

class Matrix {
    
    var  matrix : [[Int]] = []
    
    var rows: Int
    var columns: Int
    
    var paths = Array<BestPath>()
    var tempPaths = Array<BestPath>()
    
    
    init?(input : String) {
        
        let rowArray = input.components(separatedBy: "\n")
        self.rows = rowArray.count
        var columnArray = rowArray[0].components(separatedBy: ",")
        self.columns = columnArray.count
        
        matrix = Array(repeating: Array(repeating: 0, count: self.columns), count: self.rows)
        
        for i in 0..<self.rows {
            
            columnArray = rowArray[i].components(separatedBy: ",")
            
            if columnArray.count != self.columns {
                
                return nil
            }
            
            for j in 0..<self.columns {
                
                let value = columnArray[j].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                matrix[i][j] = Int(value)!
            }
        }
        
        print(matrix)
    }
    
    func findBestPath() -> BestPath {
        
        for i in 0..<self.rows {
            
            let costValue = self.matrix[i][self.columns-1]
            let path = BestPath(cost: costValue, arrayElement: i)
            
            self.paths.append(path)
        }
        
        calculateBestPath()
        
        var minCostPath:BestPath!
        
        for currentPath in self.paths {
            
            if minCostPath != nil {
                
                if(minCostPath.totalCost > currentPath.totalCost) {
                    minCostPath = currentPath
                }
            }
            else {
                minCostPath = currentPath
            }
        }
        
        return minCostPath
    }
    
    func calculateBestPath() {
        
        for col in (0...self.columns-2).reversed() {
            
            for row in 0...self.rows-1 {
            
                var topRow: Int
                var bottomRow: Int
             
                if row == 0 {
                    
                    topRow = self.rows-1
                }
                else {
                    topRow = row-1
                }
                
                if row == self.rows-1 {
                    
                    bottomRow = 0
                }
                else {
                    bottomRow = row+1
                }
                
                minimumCost(rowArray: [topRow, row, bottomRow], matrixElement: self.matrix[row][col], currentRow: row)
            }
            
            for row in 0...self.rows-1 {
            
                let bestPath = paths[row]
                let bestPathTemp = tempPaths[row]
                
                bestPath.totalCost = bestPathTemp.totalCost
                bestPath.pathArray.append(contentsOf: bestPathTemp.pathArray)
            }
            
            tempPaths.removeAll()
        }
        
        
        for row in 0...self.rows-1 {
            
            let bestPath = paths[row]
            let rowNo = bestPath.pathArray[0]
            bestPath.pathArray.remove(at: 0)
            bestPath.pathArray.append(rowNo)
        }
        
        print("Paths:")
        for bestPath in paths {
            
            print("bestPath.totalCost:\(bestPath.totalCost)")
            print("bestPath.pathArray:")
            
            for pathIndex in bestPath.pathArray.reversed() {
                
                print(pathIndex)
            }
        }
    }
    
    
    func minimumCost(rowArray: Array<Int>, matrixElement:Int, currentRow:Int) {
        
        let topCost = matrixElement + paths[rowArray[0]].totalCost
        let adjCost = matrixElement + paths[rowArray[1]].totalCost
        let bottomCost = matrixElement + paths[rowArray[2]].totalCost
        
        var path:BestPath
        
        if topCost <= adjCost  {
            
            if topCost <= bottomCost {
                
                path = BestPath(cost: topCost, arrayElement: rowArray[0])
            }
            else {
                path = BestPath(cost: bottomCost, arrayElement: rowArray[2])
            }
        }
        else {
         
            if adjCost <= bottomCost {
                
                path = BestPath(cost: adjCost, arrayElement: rowArray[1])
                
            }
            else {
                path = BestPath(cost: bottomCost, arrayElement: rowArray[2])
            }
        }
        
        self.tempPaths.append(path)
    }
    
    

    
}
