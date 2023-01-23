//
//  NewPlayer.swift
//  XOGameApp
//
//  Created by Julia on 15.12.2022.
//

import SwiftUI

struct NewPlayerView: View {
    
    @State var playerSymbol: String
    @Binding var playerName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Player \(playerSymbol)")
                .font(.system(size: 40).weight(.bold))
                .foregroundColor(.blackXO)
            CustomTextField(placeholder: Text("\(playerSymbol) player name").foregroundColor(.gray),
                            text: $playerName)
        }
    }
}

struct NewPlayer_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerView(playerSymbol: "X", playerName: .constant(""))
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
        .frame(width: 280, height: 40)
        .padding(8)
        .border(Color.blackXO, width: 2)
    }
}
