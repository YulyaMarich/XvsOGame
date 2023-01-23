//
//  XvsO.swift
//  XOGameApp
//
//  Created by Julia on 21.12.2022.
//

import SwiftUI

struct XvsOView: View {
    
    @Binding var XPlayerIsActive: Bool
    @Binding var OPlayerIsActive: Bool
    
    var nameSpace: Namespace.ID
    
    var fontSize: Double
    
    init(XPlayerIsActive: Binding<Bool> = .constant(false), OPlayerIsActive: Binding<Bool> = .constant(false), nameSpace: Namespace.ID, fontSize: Double) {
        self._XPlayerIsActive = XPlayerIsActive
        self._OPlayerIsActive = OPlayerIsActive
        self.nameSpace = nameSpace
        self.fontSize = fontSize
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text("X")
                .scaleEffect(XPlayerIsActive ? 1.3 : 1)
                .animation(XPlayerIsActive ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : Animation.default, value: XPlayerIsActive)
            
            Text("vs")
            
            Text("O")
                .scaleEffect(OPlayerIsActive ? 1.3 : 1)
                .animation(OPlayerIsActive ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : Animation.default, value: OPlayerIsActive)
        }
        .padding(.top)
        .font(.system(size: fontSize).weight(.heavy))
        .frame(width: 200)
        .foregroundColor(.blackXO)
        .matchedGeometryEffect(id: "XvsO", in: nameSpace)
    }
}

struct XvsO_Previews: PreviewProvider {
    @Namespace static var nameSpace
    
    static var previews: some View {
        XvsOView(XPlayerIsActive: .constant(false), OPlayerIsActive: .constant(false), nameSpace: nameSpace, fontSize: 42)
    }
}
