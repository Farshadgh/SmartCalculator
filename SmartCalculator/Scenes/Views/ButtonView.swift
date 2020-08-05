//
//  ButtonView.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/2/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI
import Resolver

struct CalculatorButton: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var type: CalculatorItem
    var title: String
}

struct ButtonView: View {
    
    @ObservedObject var viewModel:CalculatorViewModel = Resolver.resolve()
        
    var style: AppTheme
    
    var item: CalculatorButton
    
    init(item: CalculatorButton, style: AppTheme) {
        self.item = item
        self.style = style
    }
    
    
    var body: some View {
        Button(action: {
            self.viewModel.calculate(item: self.item)
        }) {
            Text(item.title)
            .font(.system(
                size: 22,
                weight: .semibold,
                design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(handleColor(item: item))
                .foregroundColor(style.buttonTitleColor)
                .cornerRadius(8)
        }
    }
    
    
    
    func handleColor(item: CalculatorButton) -> Color {
        switch item.type {
        case .operators:
            return style.buttonLogicColor
        default:
            return style.buttonColor
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static let service = FirebaseService()
    static let style = AppKit.Styles.Default
    static let example = CalculatorViewModel.example
    static var previews: some View {
        ButtonView(item: example, style: style)
    }
}
