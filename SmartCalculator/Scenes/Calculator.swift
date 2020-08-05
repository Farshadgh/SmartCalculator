//
//  Calculator.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/2/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


struct Coordinate {
    var latitiude: Float
    var longitude: Float
}

class Calculator {
    
    var operation: String = ""
    var currentNumber: String = "0"
    var bitcoinRate: Float = 0
    var coordinate: Coordinate?
    
    private var initiated = true
    private var baseNumber: Float = 0
    private var nextNumber: Float = 0
    private var latitude: Float = 0
    private var longitude: Float = 0
    

    private var currentOperation: OperatorItem? {
        didSet {
            guard let op = currentOperation else { return}
            self.operation(op)
        }
    }
        
    func update(item: CalculatorButton) {
        switch item.type {
        
        case .digit:
            
            operation = ""
            
            if currentOperation == nil {
                baseNumber = 0
            }
            
            if initiated {
                if currentNumber.first == "0" {
                    currentNumber.removeFirst()
                }

                currentNumber += item.title
                
            } else {
                
                initiated = true
                currentNumber = item.title
            }
            
        case .operators(let op):
            
            if let curOp = currentOperation, curOp != op  {
                if initiated { nextNumber = Float(currentNumber)! }
                operation(curOp)
                guard op != .equal else {
                    currentOperation = nil
                    updateOperationTitle(item: item)
                    return
                }
            }
            
            
            if baseNumber > 0 {
                nextNumber = currentOperation == op && initiated ?  Float(currentNumber)! : 0
            } else {
                baseNumber = Float(currentNumber)!
            }
            
            updateOperationTitle(item: item)
            initiated = false
            
            updateCurrentOperation(op: op)
            
            
        case .bitcoin:
            operation = "$"
            let context = CalculatorBitcoinStrategy(strategy: OperationBitCoin())
            let result = context.executeStrategy(num: Float(currentNumber)!, rate: bitcoinRate)
            currentNumber = result.clean
            
        case .map(let item):
            switch item {
                
            case .coordinate:
                
                operation = ""
                guard latitude != 0 , latitude != 0 else { return }
                coordinate = Coordinate(latitiude: latitude, longitude: longitude)
                
            case .lat:
                operation = "lat:"
                latitude = Float(currentNumber)!
                initiated = false
                
                
            case .lon:
                operation = "lon:"
                longitude = Float(currentNumber)!
                initiated = false
            }
            
        case .dot:
            guard currentNumber != "" else { return }
            guard !currentNumber.contains(".") else { return }
            currentNumber += "."
            
        case .reset:
            operation = ""
            currentNumber = "0"
            initiated = true
            currentOperation = nil
            coordinate = nil
            baseNumber = 0
            nextNumber = 0
            latitude = 0
            longitude = 0
            
            
        }
        
    }
    
    func updateCurrentOperation(op: OperatorItem) {
        switch op {
        case .sin, .cos, .equal:
            operation(op)
        default:
            currentOperation = op
        }
    }
    
    func updateOperationTitle(item: CalculatorButton) {
        switch item.type {
        case .operators(let op):
            switch op {
            case .cos, .sin, .equal:
                operation = ""
            default:
                operation = item.title
            }

        default:
            break
        }
    }

    func operation(_ op: OperatorItem) {
       
        guard checkToCountinueOperation(op) else { return }
        
        var result:Float = 0
        
        switch op {
        case .add:
            let context = CalculatorStrategy(strategy: OperationAdd())
            result = context.executeStrategy(num1: baseNumber, nextNumber)
            
        case .substract:
            let context = CalculatorStrategy(strategy: OperationSubstract())
            result = context.executeStrategy(num1: baseNumber, nextNumber)
            
        case .divide:
            let context = CalculatorStrategy(strategy: OperationDivide())
            result = context.executeStrategy(num1: baseNumber, nextNumber)
            
        case .multiply:
            let context = CalculatorStrategy(strategy: OperationMultiply())
            result = context.executeStrategy(num1: baseNumber, nextNumber)
            
        case .sin:
            let contect = CalculatorDegreeStrategy(strategy: OperationSinus())
            result = contect.executeStrategy(num: baseNumber)
            
        case .cos:
            let contect = CalculatorDegreeStrategy(strategy: OperationCosinus())
            result = contect.executeStrategy(num: baseNumber)
            
            
        default:
            break
        }
      
        print("Result====>", result)
        currentNumber = result.clean
        baseNumber = result
        nextNumber = 0
        
    }
    
    func checkToCountinueOperation(_ op: OperatorItem) -> Bool {
        switch op {
        case .sin, .cos:
            return true
            
        default:
            guard nextNumber != 0 else { return false }
            return true
        }
        
    }
}

