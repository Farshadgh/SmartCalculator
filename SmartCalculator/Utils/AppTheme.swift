//
//  AppTheme.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/3/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI

protocol AppTheme {
    
    var backgroundColor: Color { get }
    
    var buttonColor: Color { get }
    
    var buttonLogicColor: Color { get }
    
    var buttonTitleColor: Color { get }
    
    var displayColor: Color { get }
    
}


struct CalculatorDefaultTheme: AppTheme {
    
    var backgroundColor: Color = Color.darkBackground
    
    var buttonColor: Color = Color.darkButton
    
    var buttonLogicColor: Color = Color.lightButton
    
    var buttonTitleColor: Color = Color.displayTitleColor
    
    var displayColor: Color = Color.white
    
}


