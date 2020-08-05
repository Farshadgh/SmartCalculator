//
//  LogicPad.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/2/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI
import Resolver

struct LogicPad: View {
    
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    var style: AppTheme

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                ForEach(viewModel.others, id: \.self) {
                    ButtonView(item: $0, style: self.style)
                }
            }
            
            HStack {
                ForEach(viewModel.uriOperator, id: \.self) {
                    ButtonView(item: $0, style: self.style)
                }
            }
        }
    }
}

struct LogicPad_Previews: PreviewProvider {
    static let style = AppKit.Styles.Default
    static var previews: some View {
        LogicPad(style: style)
    }
}
