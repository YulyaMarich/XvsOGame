//
//  GameButton.swift
//  XOGameApp
//
//  Created by Julia on 23.12.2022.
//

import SwiftUI

struct GameButton: View {
    
    var buttonFunction: () -> Void
    var title: String
    var color: Color
    
    var body: some View {
        Button(action: {
            self.buttonFunction()
        }, label: {
            Text(title)
        })
        .frame(width: 180, height: UIScreen.main.bounds.height < 750 ? 15 : 20)
        .font(.title.weight(.bold))
        .foregroundColor(color)
        .padding()
        .border(Color.blackXO, width: 2)
    }
}
