//
//  SymbolButton.swift
//  XOGameApp
//
//  Created by Julia on 16.12.2022.
//

import SwiftUI

struct SymbolCell: View {
    
    var size: CGFloat
    @Binding var symbol: Symbol
    @Binding var isVisible: Bool
    @Binding var isAnimated: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: size, height: size)
            Text(symbol.rawValue)
                .font(.system(size: isAnimated ? size - 15 : size, weight: .heavy))
                .foregroundColor(.blackXO)
                .opacity(isVisible ? 1 : 0)
                .frame(width: size, height: size)
                .border(Color.blackXO, width: 3)
                .background(Color.whiteXO)
                .animation(isAnimated ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : Animation.default, value: isAnimated)
        }
    }
}

struct SymbolCell_Previews: PreviewProvider {
    static var previews: some View {
        SymbolCell(size: 100, symbol: .constant(Symbol.O), isVisible: .constant(true), isAnimated: .constant(true))
    }
}
