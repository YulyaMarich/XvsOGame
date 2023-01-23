//
//  Line.swift
//  XOGameApp
//
//  Created by Julia on 20.01.2023.
//

import SwiftUI

struct LineView: View {
    
    @Binding var width: CGFloat
    @Binding var offsetWidth: CGFloat
    @Binding var offsetHeight: CGFloat
    @Binding var rotationDegree: Double
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 8)
            .foregroundColor(.whiteXO)
            .border(Color.blackXO, width: 2)
            .rotationEffect(.degrees(rotationDegree))
            .offset(.init(width: offsetWidth, height: offsetHeight))
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView(width: .constant(250), offsetWidth: .constant(0), offsetHeight: .constant(0), rotationDegree: .constant(0))
    }
}
