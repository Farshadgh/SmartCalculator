//
//  CalculatorStrategy.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/3/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation


//MARK: - Base Operation
protocol Strategy {
    func doOperation(num1: Float, _ num2: Float) -> Float
}


class CalculatorStrategy {
    
    private var strategy: Strategy
    
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func executeStrategy(num1: Float, _ num2: Float) -> Float {
        return strategy.doOperation(num1: num1, num2)
    }
}

class OperationAdd: Strategy {
    func doOperation(num1: Float, _ num2: Float) -> Float {
        return num1 + num2
    }
}

class OperationSubstract: Strategy {
    func doOperation(num1: Float, _ num2: Float) -> Float {
        return num1 - num2
    }
}

class OperationDivide: Strategy  {
    func doOperation(num1: Float, _ num2: Float) -> Float {
        return num1 / num2
    }
}

class OperationMultiply: Strategy {
    func doOperation(num1: Float, _ num2: Float) -> Float {
        return num1 * num2
    }
}


//MARK: - Degree Operation
protocol DegreeStrategy {
    func doOperation(num: Float) -> Float
}


class CalculatorDegreeStrategy {
    private var strategy: DegreeStrategy
    
    init(strategy: DegreeStrategy) {
        self.strategy = strategy
    }
    
    func executeStrategy(num: Float) -> Float {
        return strategy.doOperation(num: num)
    }
    
}



class OperationSinus: DegreeStrategy {
    func doOperation(num: Float) -> Float {
        return sin(num * Float.pi / 180)
    }
}

class OperationCosinus: DegreeStrategy {
    func doOperation(num: Float) -> Float {
        cos(num * Float.pi / 180)
    }
}




//MARK: - Bitcoin Operation

protocol BitcoinStrategy {
    func doOperation(num: Float, rate: Float) -> Float
}

class CalculatorBitcoinStrategy {
    
    private var strategy: BitcoinStrategy
    
    
    init(strategy: BitcoinStrategy) {
        self.strategy = strategy
    }
    
    func executeStrategy(num: Float, rate: Float) -> Float {
        return strategy.doOperation(num: num, rate: rate)
    }
}


class OperationBitCoin: BitcoinStrategy {
    func doOperation(num: Float, rate: Float) -> Float {
        return num * rate
    }
}
