//
//  CalculatorViewModel.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/3/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import Resolver
import Combine

enum OperatorItem {
    case add
    case substract
    case multiply
    case divide
    case sin
    case cos
    case equal
}


enum CalculatorItem: Hashable {
    
    case operators(OperatorItem)
    case digit
    case dot
    case reset
    case map(MapItem)
    case bitcoin
}

enum MapItem {
    case lat
    case lon
    case coordinate
}


class CalculatorViewModel: ObservableObject  {
    
    @Injected var calculator: Calculator
    
    
    @Published var operation: String = ""
    @Published var currentNumber: String = "0"
    @Published var isLoaded: Bool = false
    
    @Published var locationName: String? {
        didSet {
            guard let name = locationName else { return }
            self.currentNumber = name
        }
    }
    
    @Published var bitcoinRate: Float = 0 {
        didSet {
            calculator.bitcoinRate = bitcoinRate
        }
    }
    @Published var resError: AppError? = nil
    
    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.resError != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.resError = nil
        })
    }
    
    @Published var dataRepo: ResourcesDataBase = Resolver.resolve()
    @Published var featureModel: FeatureModel? {
        didSet {
            guard let model = featureModel else { return }
            handleHiddenItem(response: model)
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        currentNumber = calculator.currentNumber
        operation = calculator.operation
        
        dataRepo.$bitcoin
            .assign(to: \.bitcoinRate, on: self)
            .store(in: &cancellables)
        
        dataRepo.$feature
            .assign(to: \.featureModel, on: self)
            .store(in: &cancellables)
        
        dataRepo.$resError
            .assign(to: \.resError, on: self)
            .store(in: &cancellables)
        
        dataRepo.$location
            .assign(to: \.locationName, on: self)
            .store(in: &cancellables)
        
        
    }
    
    
    func calculate(item: CalculatorButton) {
        
        calculator.update(item: item)
        
        switch item.type {
        case .map(let item):
            switch item {
            case .coordinate:
                guard let coord = calculator.coordinate else { return }
                dataRepo.fetchCoordinate(lat: coord.latitiude, lon: coord.longitude)
                
            default:
                break
            }
            
        default:
            break
        }
        
        
        currentNumber = calculator.currentNumber
        operation = calculator.operation
        
    }
 
    
    //MARK: - UI Element Interface
    //=============================
    //=============================
    
    @Published var items1 = [
        CalculatorButton(type: .digit, title: "7"),
        CalculatorButton(type: .digit, title: "4"),
        CalculatorButton(type: .digit, title: "1"),
        CalculatorButton(type: .digit, title: "0")
    ]
    
    @Published var operatorsItems = [
        CalculatorButton(type: .operators(.add), title: "+"),
        CalculatorButton(type: .operators(.divide), title: "÷"),
        CalculatorButton(type: .operators(.multiply), title: "×"),
        CalculatorButton(type: .operators(.substract), title: "−")
    ]
    
    @Published var items2 = [
        CalculatorButton(type: .digit, title: "8"),
        CalculatorButton(type: .digit, title: "5"),
        CalculatorButton(type: .digit, title: "2"),
        CalculatorButton(type: .dot, title: ".")
    ]
    
    
    @Published var items3 = [
        CalculatorButton(type: .digit, title: "9"),
        CalculatorButton(type: .digit, title: "6"),
        CalculatorButton(type: .digit, title: "3"),
        CalculatorButton(type: .operators(.equal), title: "=")
    ]
    
    @Published var uriOperator = [
        CalculatorButton(type: .bitcoin, title: "💰"),
        CalculatorButton(type: .map(.lat), title: "lat"),
        CalculatorButton(type: .map(.lon), title: "lon"),
        CalculatorButton(type: .map(.coordinate), title: "📍")
    ]
    
    @Published var others = [
        CalculatorButton(type: .reset, title: "clear"),
        CalculatorButton(type: .operators(.sin), title: "sin"),
        CalculatorButton(type: .operators(.cos), title: "cos"),
    ]
}

private extension CalculatorViewModel {
    
    
    func handleHiddenItem(response: FeatureModel) {
        if !response.add {
            operatorsItems = operatorsItems.filter { $0.type != .operators(.add) }
        }
        if !response.multiply {
            operatorsItems = operatorsItems.filter { $0.type != .operators(.multiply) }
        }
        if !response.substract {
            operatorsItems = operatorsItems.filter { $0.type != .operators(.substract) }
        }
        if !response.divide {
            operatorsItems = operatorsItems.filter { $0.type != .operators(.divide) }
        }
        if !response.sin {
            uriOperator = uriOperator.filter { $0.type != .operators(.sin) }
        }
        if !response.cos {
            others = others.filter { $0.type != .operators(.cos) }
        }
        if !response.map {
            uriOperator = uriOperator.filter { $0.type != .map(.coordinate) && $0.type != .map(.lat) && $0.type != .map(.lon) }
        }
        if !response.bitcoin {
            uriOperator = uriOperator.filter { $0.type != .bitcoin }
        }
        
    }
}



// Examples
extension CalculatorViewModel {
    static let exampleViewModel = CalculatorViewModel()
}

extension CalculatorViewModel {
    static let example = CalculatorButton(type: .digit, title: "9")
}
