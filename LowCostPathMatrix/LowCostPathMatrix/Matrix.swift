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
        let rows = rowArray.count
        var columnArray = rowArray[0].components(separatedBy: ",")
        let columns = columnArray.count
        
        //Initialize input matrix
        self.inputMatrix = Array(repeating: Array(repeating: Cost(cost: Int(0), gridRow: 0), count: columns), count: rows)
        
        //Fill the input matrix with input data
        for i in 0..<rows {
            
            columnArray = rowArray[i].components(separatedBy: ",")
            
            //Condition to check all the rows contains same number of columns
            if columnArray.count != columns {
                
                return nil
            }
            
            for j in 0..<columns {
                
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
}
