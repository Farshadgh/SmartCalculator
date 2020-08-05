//
//  DisplayView.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/3/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI

struct DisplayView: View {
    
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    var style: AppTheme
    
    init(style: AppTheme) {
        self.style = style
    }
    
    var body: some View {
        HStack(alignment: .bottom) {

            Text(viewModel.operation)
            
            Spacer()
            
            Text(viewModel.currentNumber)
                .multilineTextAlignment(.trailing)
            
        }
        .font(Font.system(size: 35, weight: .bold, design: .monospaced))
        .foregroundColor(style.displayColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .padding()
    }
}

struct DisplayView_Previews: PreviewProvider {
    static let style = AppKit.Styles.Default
    static let calc = Calculator()
    static var previews: some View {
        DisplayView(style: style)
    }
}
