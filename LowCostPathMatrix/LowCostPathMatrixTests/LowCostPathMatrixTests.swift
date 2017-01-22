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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK:- Test Case for 5 x 6 Matrix
    func testLowCostPathInMatrix_5X6() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,3,9,9,5\n8,4,1,3,2,6\n3,7,2,8,6,4"
        
        let matrix = Matrix(input: matrixString)
        
        let minCost = matrix?.findBestCost()
        
        // Test to match the result
        
        if let pathCompleted = minCost?.traversedCompletePath {
            
            XCTAssertTrue(pathCompleted)
        }
        
        if let minGridCostTotal = minCost?.gridCostUptoMaximum {
        
            XCTAssertEqual(16, minGridCostTotal)
        }
        
        if let lowCostPath = minCost?.costPathUptoMaximum {
        
            XCTAssertEqual([1, 2, 3, 4, 4, 5], lowCostPath)
        }
    }
    
    //MARK:- Test Case for 1 x 5 Matrix (Single Row)
    func testLowCostPathInMatrix_1X6() {
        
        let matrixString = "3,4,1,2,8"
        
        let matrix = Matrix(input: matrixString)
        
        let minCost = matrix?.findBestCost()
        
        // Test to match the result
        
        if let pathCompleted = minCost?.traversedCompletePath {
            
            XCTAssertTrue(pathCompleted)
        }
        
        if let minGridCostTotal = minCost?.gridCostUptoMaximum {
            
            XCTAssertEqual(18, minGridCostTotal)
        }
        
        if let lowCostPath = minCost?.costPathUptoMaximum {
            
            XCTAssertEqual([1, 1, 1, 1, 1], lowCostPath)
        }
    }
    
    //MARK:- Test Case for 5 x 1 Matrix (Single Column)
    func testLowCostPathInMatrix_5X1() {
        
        let matrixString = "3\n4\n1\n2\n8"
        
        let matrix = Matrix(input: matrixString)
        
        let minCost = matrix?.findBestCost()
        
        // Test to match the result
        
        if let pathCompleted = minCost?.traversedCompletePath {
            
            XCTAssertTrue(pathCompleted)
        }
        
        if let minGridCostTotal = minCost?.gridCostUptoMaximum {
            
            XCTAssertEqual(1, minGridCostTotal)
        }
        
        if let lowCostPath = minCost?.costPathUptoMaximum {
            
            XCTAssertEqual([3], lowCostPath)
        }
    }
    
    //MARK:- Test Case for total cost > 50
    func testLowCostPathInMatrixForCostGreater_50() {
        
        let matrixString = "19,10,19,10,19\n21,23,20,19,12\n20,12,20,11,10"
        
        let matrix = Matrix(input: matrixString)
        
        let minCost = matrix?.findBestCost()
        
        // Test to match the result
        
        if let pathCompleted = minCost?.traversedCompletePath {
            
            XCTAssertFalse(pathCompleted)
        }
        
        if let minGridCostTotal = minCost?.gridCostUptoMaximum {
            
            XCTAssertEqual(48, minGridCostTotal)
        }
        
        if let lowCostPath = minCost?.costPathUptoMaximum {
            
            XCTAssertEqual([1,1,1], lowCostPath)
        }
    }
    
    //MARK:- Test Case for total cost starting with > 50
    func testLowCostPathInMatrixForFirstColumnCostGreater_50() {
        
        let matrixString = "69,10,19,10,19\n51,23,20,19,12\n60,12,20,11,10"
        
        let matrix = Matrix(input: matrixString)
        
        let minCost = matrix?.findBestCost()
        
        // Test to match the result
        
        if let pathCompleted = minCost?.traversedCompletePath {
            
            XCTAssertFalse(pathCompleted)
        }
        
        if let minGridCostTotal = minCost?.gridCostUptoMaximum {
            
            XCTAssertEqual(0, minGridCostTotal)
        }
        
        if let lowCostPath = minCost?.costPathUptoMaximum {
            
            XCTAssertEqual([], lowCostPath)
        }
    }
    
    //MARK:- Test Case for Invalid Matrix - One column has more size
    func testInvalidInputMatrixWithDifferentColumnSize() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,3,9,9,5\n8,4,1,3,2,6\n3,7,2,3,6"
        
        let matrix = Matrix(input: matrixString)
        
        XCTAssertNil(matrix)
    }
    
    //MARK:- Test Case for Invalid Matrix - Invalid characters entered
    func testInvalidInputMatrixWithInvalidCharacters() {
        
        let matrixString = "3,4,1,2,8,6\n6,1,8,2,7,4\n5,9,a,9,9,5\n8,4,1,3,2,6\n3,7,2,8,6,4"
        
        let matrix = Matrix(input: matrixString)
        
        XCTAssertNil(matrix)
    }
    
    //MARK:- Test Case for Invalid Matrix - No Input
    func testInvalidInputMatrixWithNoInput() {
        
        let matrixString = ""
        
        let matrix = Matrix(input: matrixString)
        
        XCTAssertNil(matrix)
    }
}
