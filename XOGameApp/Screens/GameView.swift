//
//  GameView.swift
//  XOGameApp
//
//  Created by Julia on 21.12.2022.
//

import SwiftUI

struct GameView: View {
    
    var nameSpace: Namespace.ID
    
    @State var XPlayerIsActive = false
    @State var OPlayerIsActive = false
    @State var isFlipped = false
    @State var goOn = false
    @State var lineIsVisible = false
    @State var isSymbolVisible = [false, false, false, false, false, false, false, false, false]
    @State var isSymbolAnimated = [false, false, false, false, false, false, false, false, false]
    
    @State var firstPalyerName = ""
    @State var secondPlayerName = ""
    
    @State var text = ""
    @State var playerName = ""
    @State var buttonTitle = "START GAME"
    
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    
    @State var counter = 0
    
    @State var horizontalLineOffset: CGFloat = 0
    @State var verticalLineOffset: CGFloat = 0
    @State var lineRotationDegree: Double = 0
    
    let durationAndDelay : CGFloat = 0.3
    
    @State var symbols: [Symbol] = [.X, .X, .X, .X, .X, .X, .X, .X, .X]
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        VStack {
            XvsOView(XPlayerIsActive: $XPlayerIsActive,
                     OPlayerIsActive: $OPlayerIsActive,
                     nameSpace: nameSpace,
                     fontSize: 45)
            .offset(y: -keyboardResponder.currentHeight)
            
            Text(text)
                .padding(.top, 10)
                .opacity(isFlipped ? 1 : 0)
                .foregroundColor(.blackXO)
            
            Spacer()
            
            ZStack {
                GameSideView(XPlayerIsActive: $XPlayerIsActive,
                             OPlayerIsActive: $OPlayerIsActive,
                             goOn: $goOn,
                             lineIsVisible: $lineIsVisible,
                             isSymbolVisible: $isSymbolVisible,
                             isSymbolAnimated: $isSymbolAnimated,
                             firstPalyerName: $firstPalyerName,
                             secondPlayerName: $secondPlayerName,
                             text: $text,
                             playerName: $playerName,
                             degree: $frontDegree,
                             counter: $counter,
                             horizontalLineOffset: $horizontalLineOffset,
                             verticalLineOffset: $verticalLineOffset,
                             lineRotationDegree: $lineRotationDegree,
                             symbols: $symbols)
                
                RegistrationSideView(degree: $backDegree,
                                     firstPalyerName: $firstPalyerName,
                                     secondPlayerName: $secondPlayerName,
                                     goToGame: {flipCard() })
            }
            
            Spacer()
            
            VStack() {
                GameButton(buttonFunction: { self.restart() },
                           title: "RESTART",
                           color: .blackXO)
                .opacity(isFlipped ? 1 : 0)
                
                GameButton(buttonFunction: { self.flipCard() },
                           title: buttonTitle,
                           color: enterIsNotPermited() ? .gray : .blackXO)
                .offset(y: -keyboardResponder.currentHeight)
                .disabled(enterIsNotPermited())
            }
            .padding(.top, UIScreen.main.bounds.height < 750 ? 90 : 80)
            
            Spacer()
        }
        .background(Color.whiteXO)
        .onTapGesture {
            dissmissKeyboard()
        }
    }
    
    func enterIsNotPermited() -> Bool {
        if firstPalyerName == "" || secondPlayerName == "" || firstPalyerName.first == " " || secondPlayerName.first == " " {
            return true
        } else {
            return false
        }
    }
    
    func flipCard () {
        if !enterIsNotPermited() {
            withAnimation(.spring(response: 1)) {
                isFlipped = !isFlipped
                text = "\(firstPalyerName), it is your turn"
                XPlayerIsActive.toggle()
                goOn.toggle()
            }
            
            buttonTitle = "QUIT GAME"
            
            if isFlipped {
                withAnimation(.linear(duration: durationAndDelay)) {
                    backDegree = 90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    frontDegree = 0
                }
            } else {
                withAnimation(.linear(duration: durationAndDelay)) {
                    frontDegree = -90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    backDegree = 0
                }
                
                cleanAll()
                buttonTitle = "START GAME"
                XPlayerIsActive = false
                OPlayerIsActive = false
                goOn = false
            }
        }
    }
    
    func restart() {
        cleanAll()
        XPlayerIsActive = true
        OPlayerIsActive = false
        text = "\(firstPalyerName), it is your turn"
        goOn = true
    }
    
    func cleanAll() {
        withAnimation(.spring(response: 0.9)) {
            isSymbolVisible = [false, false, false, false, false, false, false, false, false]
            isSymbolAnimated = [false, false, false, false, false, false, false, false, false]
            counter = 0
            lineIsVisible = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            horizontalLineOffset = 0
            verticalLineOffset = 0
            lineRotationDegree = 0
        }
    }
}

struct Game_Previews: PreviewProvider {
    @Namespace static var nameSpace
    
    static var previews: some View {
        GameView(nameSpace: nameSpace)
    }
}

