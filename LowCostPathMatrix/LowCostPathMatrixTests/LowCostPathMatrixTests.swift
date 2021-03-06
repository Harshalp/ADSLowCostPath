//
//  LowCostPathMatrixTests.swift
//  LowCostPathMatrixTests
//
//  Created by harshal_s on 1/18/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//

import XCTest
@testable import LowCostPathMatrix

class LowCostPathMatrixTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- Test Case for 5 x 6 Matrix
    func testLowCostPathInMatrix_5X6() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,3,9,9,5\n8,4,1,3,2,6\n3,7,2,8,6,4"
        
        do {
            let matrix = try Matrix(input: matrixString)
            
            XCTAssertNotNil(matrix)
        
            let lowCostAlgo = LowCostFinder()
            let minCost = lowCostAlgo.findBestCostFor(matrix: (matrix?.inputMatrix)!)
        
            XCTAssertTrue(minCost.traversedCompletePath)
            XCTAssertEqual(16, minCost.gridCostUptoMaximum)
            XCTAssertEqual([1, 2, 3, 4, 4, 5], minCost.costPathUptoMaximum)
        } catch {
        }
        
    }
    
    //MARK:- Test Case for 1 x 5 Matrix (Single Row)
    func testLowCostPathInMatrix_1X6() {
        
        let matrixString = "3,4,1,2,8"
        
        do {
        
            let matrix = try Matrix(input: matrixString)
            XCTAssertNotNil(matrix)
            
            let lowCostAlgo = LowCostFinder()
            let minCost = lowCostAlgo.findBestCostFor(matrix: (matrix?.inputMatrix)!)
            
            XCTAssertTrue(minCost.traversedCompletePath)
            XCTAssertEqual(18, minCost.gridCostUptoMaximum)
            XCTAssertEqual([1, 1, 1, 1, 1], minCost.costPathUptoMaximum)
        } catch {
        }
    }
    
    //MARK:- Test Case for 5 x 1 Matrix (Single Column)
    func testLowCostPathInMatrix_5X1() {
        
        let matrixString = "3\n4\n1\n2\n8"
        
        do {
            let matrix = try Matrix(input: matrixString)
            
            XCTAssertNotNil(matrix)
            
            let lowCostAlgo = LowCostFinder()
            let minCost = lowCostAlgo.findBestCostFor(matrix: (matrix?.inputMatrix)!)
            
            XCTAssertTrue(minCost.traversedCompletePath)
            XCTAssertEqual(1, minCost.gridCostUptoMaximum)
            XCTAssertEqual([3], minCost.costPathUptoMaximum)
        } catch {
        }
    }
    
    //MARK:- Test Case for total cost > 50
    func testLowCostPathInMatrixForCostGreater_50() {
        
        let matrixString = "19,10,19,10,19\n21,23,20,19,12\n20,12,20,11,10"
        
        do {
        
            let matrix = try Matrix(input: matrixString)
            
            XCTAssertNotNil(matrix)
            
            let lowCostAlgo = LowCostFinder()
            let minCost = lowCostAlgo.findBestCostFor(matrix: (matrix?.inputMatrix)!)
            
            XCTAssertFalse(minCost.traversedCompletePath)
            XCTAssertEqual(48, minCost.gridCostUptoMaximum)
            XCTAssertEqual([1,1,1], minCost.costPathUptoMaximum)
        }catch {
        }
    }
    
    //MARK:- Test Case for total cost starting with > 50
    func testLowCostPathInMatrixForFirstColumnCostGreater_50() {
        
        let matrixString = "69,10,19,10,19\n51,23,20,19,12\n60,12,20,11,10"
        
        do {
            
            let matrix = try Matrix(input: matrixString)
            XCTAssertNotNil(matrix)
            
            let lowCostAlgo = LowCostFinder()
            let minCost = lowCostAlgo.findBestCostFor(matrix: (matrix?.inputMatrix)!)
            
            XCTAssertFalse(minCost.traversedCompletePath)
            XCTAssertEqual(0, minCost.gridCostUptoMaximum)
            XCTAssertEqual([], minCost.costPathUptoMaximum)
        } catch {
        }
    }
    
    //MARK:- Test Case for Invalid Matrix - One column has more size
    func testInvalidInputMatrixWithDifferentColumnSize() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,3,9,9,5\n8,4,1,3,2,6\n3,7,2,3,6"
        
        do {
            let matrix = try Matrix(input: matrixString)
            XCTAssertNil(matrix)
        } catch {
        }
    }
    
    //MARK:- Test Case for Invalid Matrix - Invalid characters entered
    func testInvalidInputMatrixWithInvalidCharacters() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,a,9,9,5\n8,4,1,3,2,6\n3,7,2,8,6,4"
        
        do {
            let matrix = try Matrix(input: matrixString)
        
            XCTAssertNil(matrix)
        } catch {
        }
    }
    
    //MARK:- Test Case for Invalid Matrix - No Input
    func testInvalidInputMatrixWithNoInput() {
        
        let matrixString = ""
        
        do {
            let matrix = try Matrix(input: matrixString)
            XCTAssertNil(matrix)
        } catch {
        }
        
    }
    
    //MARK:- Test Case for Negative numbers in matrix
    func testInputMatrixWithNegativeNumbersInput() {
        
        let matrixString = "6,3,-5,10\n-5,2,4,10\n3,-2,6,10\n6,-1,-2,10"
        
        do {
            let matrix = try Matrix(input: matrixString)
        
            XCTAssertNotNil(matrix)
        
            let lowCostAlgo = LowCostFinder()
            let minCost = lowCostAlgo.findBestCostFor(matrix:(matrix?.inputMatrix)!)
        
            XCTAssertTrue(minCost.traversedCompletePath)
            XCTAssertEqual(1, minCost.gridCostUptoMaximum)
            XCTAssertEqual([2,3,4,1], minCost.costPathUptoMaximum)
        } catch {
        }
    }
    
    //MARK:- Test case for adjacent rows
    func testGetAdjacentRowsMethod() {
     
        let lowCostAlgo = LowCostFinder()
        let (topAdjacent,bottomAdjacent) = lowCostAlgo.getAdjacentRows(row: 0, totalRows: 3)
        
        XCTAssertEqual(2, topAdjacent)
        XCTAssertEqual(1, bottomAdjacent)
    }
    
    //MARK:- Test low cost method which returns lowest cost from array
    func testSearchLowCostInMethod() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,3,9,9,5\n8,4,1,3,2,6\n3,7,2,8,6,4"
        
        do {
            let matrix = try Matrix(input: matrixString)
            XCTAssertNotNil(matrix)
        
            let lowCostAlgo = LowCostFinder()
            lowCostAlgo.initializeArrays(matrix: (matrix?.inputMatrix)!)
            let minCost = lowCostAlgo.searchLowCostIn(costs: lowCostAlgo.additionColumn)
        
            XCTAssertEqual(3, minCost.gridCost)
        } catch {
        }
    }
}
