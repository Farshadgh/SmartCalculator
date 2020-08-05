//
//  CalculatorTests.swift
//  SmartCalculatorTests
//
//  Created by Farshad Ghafari on 8/4/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import XCTest
@testable import SmartCalculator

class CalculatorTests: XCTestCase {
    
    var calculator: Calculator!

    override func setUp() {
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
    }

    func testAddTwoNumber() {
        let numberOne = CalculatorButton(type: .digit, title: "9")
        calculator.update(item: numberOne)
        
        let add = CalculatorButton(type: .operators(.add), title: "+")
        calculator.update(item: add)
        
        let numberTwo = CalculatorButton(type: .digit, title: "10")
        calculator.update(item: numberTwo)
        
        let equal = CalculatorButton(type: .operators(.equal), title: "=")
        calculator.update(item: equal)
        
        XCTAssertEqual(calculator.currentNumber, "19")
        
    }
    
    func testSubtractTwoNumber() {
        let numberOne = CalculatorButton(type: .digit, title: "9")
        calculator.update(item: numberOne)
        
        let sub = CalculatorButton(type: .operators(.substract), title: "-")
        calculator.update(item: sub)
        
        let numberTwo = CalculatorButton(type: .digit, title: "1")
        calculator.update(item: numberTwo)
        
        let equal = CalculatorButton(type: .operators(.equal), title: "=")
        calculator.update(item: equal)
        
        XCTAssertEqual(calculator.currentNumber, "8")
        
    }
    
    func testMultiplyTwoNumber() {
        let numberOne = CalculatorButton(type: .digit, title: "9")
        calculator.update(item: numberOne)
        
        let sub = CalculatorButton(type: .operators(.multiply), title: "*")
        calculator.update(item: sub)
        
        let numberTwo = CalculatorButton(type: .digit, title: "2")
        calculator.update(item: numberTwo)
        
        let equal = CalculatorButton(type: .operators(.equal), title: "=")
        calculator.update(item: equal)
        
        XCTAssertEqual(calculator.currentNumber, "18")
        
    }
    
    func testDevideTwoNumber() {
        let numberOne = CalculatorButton(type: .digit, title: "10")
        calculator.update(item: numberOne)
        
        let sub = CalculatorButton(type: .operators(.divide), title: "÷")
        calculator.update(item: sub)
        
        let numberTwo = CalculatorButton(type: .digit, title: "2")
        calculator.update(item: numberTwo)
        
        let equal = CalculatorButton(type: .operators(.equal), title: "=")
        calculator.update(item: equal)
        
        XCTAssertEqual(calculator.currentNumber, "5")
        
    }
    
    func testSin() {
        let number = CalculatorButton(type: .digit, title: "1")
        calculator.update(item: number)
           
        let equal = CalculatorButton(type: .operators(.sin), title: "sin")
        calculator.update(item: equal)
           
        XCTAssertEqual(calculator.currentNumber, "0.017452406")
              
    }
    
    func testCos() {
         let number = CalculatorButton(type: .digit, title: "1")
         calculator.update(item: number)
            
         let equal = CalculatorButton(type: .operators(.cos), title: "cos")
         calculator.update(item: equal)
            
         XCTAssertEqual(calculator.currentNumber, "0.9998477")
               
     }
}
