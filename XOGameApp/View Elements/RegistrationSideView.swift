//
//  RegistrationSide.swift
//  XOGameApp
//
//  Created by Julia on 26.12.2022.
//

import SwiftUI

struct RegistrationSideView : View {
    
    @Binding var degree : Double
    
    @Binding var firstPalyerName: String
    @Binding var secondPlayerName: String
    
    @FocusState private var focusedField: Field?
    
    var goToGame: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height < 750 ? 30 : 50) {
            NewPlayerView(playerSymbol: "X",
                          playerName: $firstPalyerName)
            .focused($focusedField, equals: .firstUserNameField)
            
            NewPlayerView(playerSymbol: "O",
                          playerName: $secondPlayerName)
            .focused($focusedField, equals: .secondUserNameField)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button(action: {
                    if focusedField == .firstUserNameField {
                        focusedField = .secondUserNameField
                    }  else {
                        goToGame()
                    }
                }, label: {
                    if focusedField == .firstUserNameField {
                        Text("Next")
                            .foregroundColor(.black)
                    } else {
                        Text("START GAME")
                            .foregroundColor(.black)
                    }
                })
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
