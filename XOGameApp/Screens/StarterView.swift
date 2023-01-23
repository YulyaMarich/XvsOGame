//
//  Starter.swift
//  XOGameApp
//
//  Created by Julia on 15.12.2022.
//

import SwiftUI

struct StarterView: View {
    
    var nameSpace: Namespace.ID
    
    @State var tapToStart = false
    
    var body: some View {
        ZStack {
            if !tapToStart {
                VStack() {
                    Spacer()
                    
                    XvsOView(nameSpace: nameSpace, fontSize: 50)
                    
                    Spacer()
                    
                    Text("Tap to start")
                        .padding()
                        .foregroundColor(.blackXO)
                }
                .frame(maxWidth: .infinity)
                .background(Color.whiteXO)
                .onTapGesture(count: 1) {
                    withAnimation(.easeOut(duration: 0.7)) {
                        tapToStart = true
                    }
                }
            }
            
            if tapToStart {
                GameView(nameSpace: nameSpace)
            }
        }
    }
}


struct Starter_Previews: PreviewProvider {
    @Namespace static var nameSpace
    
    static var previews: some View {
        StarterView(nameSpace: nameSpace)
    }
}
