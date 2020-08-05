//
//  NumPadView.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/2/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI
import Resolver



struct NumPadView: View {

    @EnvironmentObject var viewModel: CalculatorViewModel

    var style: AppTheme
    
    
    var body: some View {

        VStack(spacing: 5) {

            HStack(spacing: 5) {
                 
                VStack(spacing: 5) {
                    ForEach(viewModel.items1, id: \.self) {
                        ButtonView(item: $0, style: self.style)
                    }
                }
                
                VStack(spacing: 5) {
                    ForEach(viewModel.items2, id: \.self) {
                        ButtonView(item: $0, style: self.style)
                    }
                }
                
                VStack(spacing: 5) {
                    ForEach(viewModel.items3, id: \.self) {
                        ButtonView(item: $0, style: self.style)
                   }
               }
                
                VStack(spacing: 5) {
                    ForEach(viewModel.operatorsItems, id: \.self) {
                        ButtonView(item: $0, style: self.style)
                    }
                }
            }
        }

    }

}

struct NumPadView_Previews: PreviewProvider {
    static let style = AppKit.Styles.Default
    static var previews: some View {
        NumPadView(style: style)
    }
}
