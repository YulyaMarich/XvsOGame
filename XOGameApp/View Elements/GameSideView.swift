//
//  GameGrid.swift
//  XOGameApp
//
//  Created by Julia on 21.12.2022.
//

import SwiftUI

struct GameSideView: View {
    
    @Binding var XPlayerIsActive: Bool
    @Binding var OPlayerIsActive: Bool
    
    @Binding var goOn: Bool
    
    @Binding var lineIsVisible: Bool
    
    @Binding var isSymbolVisible: [Bool]
    @Binding var isSymbolAnimated: [Bool]
    
    @Binding var firstPalyerName: String
    @Binding var secondPlayerName: String
    
    @Binding var text: String
    @Binding var playerName: String
    
    @Binding var degree : Double
    @Binding var counter: Int
    
    @State var lineLength: CGFloat = 0
    @Binding var horizontalLineOffset: CGFloat
    @Binding var verticalLineOffset: CGFloat
    @Binding var lineRotationDegree: Double
    
    @State var winningCombination = Combination.horizontall(parallel: .upper)
    @State var screenWidth: CGFloat = 0
    
    @Binding var symbols: [Symbol]
    
    var columns: [GridItem] = [
        GridItem(.fixed(90)),
        GridItem(.fixed(90)),
        GridItem(.fixed(90))
    ]
    
    var body: some View {
        GeometryReader { g in
            VStack {
                Spacer()
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) { index in
                        SymbolCell(size: 90, symbol: $symbols[index], isVisible: $isSymbolVisible[index], isAnimated: $isSymbolAnimated[index])
                            .onTapGesture {
                                if goOn {
                                    if !isSymbolVisible[index] {
                                        if XPlayerIsActive {
                                            symbols[index] = .X
                                            XPlayerIsActive.toggle()
                                            OPlayerIsActive.toggle()
                                            text = "\(secondPlayerName), it is your turn"
                                        } else {
                                            symbols[index] = .O
                                            XPlayerIsActive.toggle()
                                            OPlayerIsActive.toggle()
                                            playerName = firstPalyerName
                                            text = "\(firstPalyerName), it is your turn"
                                        }
                                        withAnimation(.spring(response: 1)) {
                                            isSymbolVisible[index] = true
                                        }
                                        
                                        counter += 1
                                        if counter == 9 {
                                            OPlayerIsActive = false
                                            text = "Game is over"
                                        }
                                        
                                        checkAllCombinations()
                                        
                                    }
                                }
                            }
                    }
                }
                .overlay {
                    LineView(width: $lineLength, offsetWidth: $horizontalLineOffset, offsetHeight: $verticalLineOffset, rotationDegree: $lineRotationDegree)
                        .opacity(lineIsVisible ? 1 : 0)
                }
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
                .onAppear {
                    screenWidth = g.size.width
                }
                
                Spacer()
            }
        }
    }
    
    func checkAllCombinations() {
        for i in 0...2 {
            if checkHorizontalWith(symbol: .X, at: i*3) || checkVerticalWith(symbol: .X, at: i) || checkDiagonalsWith(symbol: .X) {
                text = "\(firstPalyerName) is winner"
                OPlayerIsActive = false
                changeLine(on: winningCombination)
            } else if checkHorizontalWith(symbol: .O, at: i*3) || checkVerticalWith(symbol: .O, at: i) || checkDiagonalsWith(symbol: .O) {
                text = "\(secondPlayerName) is winner"
                XPlayerIsActive = false
                changeLine(on: winningCombination)
            }
        }
    }
    
    func checkVerticalWith(symbol: Symbol, at index: Int) -> Bool {
        if isSymbolVisible[index] && symbols[index] == symbol && isSymbolVisible[index + 3] && symbols[index + 3] == symbol && isSymbolVisible[index + 6] && symbols[index + 6] == symbol {
            animateSymbolAt(firstIndex: index, secondIndex: index + 3, thirdIndex: index + 6)
            if index == 0 {
                winningCombination = .vertcal(parallel: .left)
            } else if index == 1 {
                winningCombination = .vertcal(parallel: .middle)
            } else if index == 2 {
                winningCombination = .vertcal(parallel: .rigth)
            }
            return true
        } else {
            return false
        }
    }
    
    func checkHorizontalWith(symbol: Symbol, at index: Int) -> Bool {
        if isSymbolVisible[index] && symbols[index] == symbol && isSymbolVisible[index + 1] && symbols[index + 1] == symbol && isSymbolVisible[index + 2] && symbols[index + 2] == symbol {
            animateSymbolAt(firstIndex: index, secondIndex: index + 1, thirdIndex: index + 2)
            if index == 0 {
                winningCombination = .horizontall(parallel: .upper)
            } else if index == 3 {
                winningCombination = .horizontall(parallel: .middle)
            } else if index == 6{
                winningCombination = .horizontall(parallel: .lower)
            }
            return true
        } else {
            return false
        }
    }
    
    func changeLine(on parallel: Combination) {
        goOn = false
        lineLength = screenWidth - 45
        switch parallel {
        case .horizontall(let parallel):
            switch parallel {
            case .upper:
                verticalLineOffset = -100
            case .middle:
                verticalLineOffset = 0
            case .lower:
                verticalLineOffset = 100
            }
        case .vertcal(let parallel):
            switch parallel {
            case .left:
                horizontalLineOffset = -100
            case .middle:
                horizontalLineOffset = 0
            case .rigth:
                horizontalLineOffset = 100
            }
            lineRotationDegree = 90
        case .diagonal(let line):
            lineLength = screenWidth + 45
            switch line {
            case .first:
                lineRotationDegree = 45
            case .second:
                lineRotationDegree = 135
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation() {
                lineIsVisible = true
            }
        }
    }
    
    func checkDiagonalsWith(symbol: Symbol) -> Bool {
        if isSymbolVisible[0] && symbols[0] == symbol && isSymbolVisible[4] && symbols[4] == symbol && isSymbolVisible[8] && symbols[8] == symbol {
            animateSymbolAt(firstIndex: 0, secondIndex: 4, thirdIndex: 8)
            winningCombination = .diagonal(line: .first)
            return true
        } else if isSymbolVisible[2] && symbols[2] == symbol && isSymbolVisible[4] && symbols[4] == symbol && isSymbolVisible[6] && symbols[6] == symbol {
            animateSymbolAt(firstIndex:2, secondIndex: 4, thirdIndex: 6)
            winningCombination = .diagonal(line: .second)
            return true
        } else {
            return false
        }
    }
    
    func animateSymbolAt(firstIndex: Int, secondIndex: Int, thirdIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            isSymbolAnimated[firstIndex] = true
            isSymbolAnimated[secondIndex] = true
            isSymbolAnimated[thirdIndex] = true
        }
    }
}

struct GameGrid_Previews: PreviewProvider {
    static var previews: some View {
        GameSideView(XPlayerIsActive: .constant(false),
                     OPlayerIsActive: .constant(false),
                     goOn: .constant(false),
                     lineIsVisible: .constant(false),
                     isSymbolVisible: .constant([false, false, false, false, false, false, false, false, false]),
                     isSymbolAnimated: .constant([false, false, false, false, false, false, false, false, false]),
                     firstPalyerName: .constant("Yuliia"),
                     secondPlayerName: .constant(""),
                     text: .constant(""),
                     playerName: .constant("Oleh"),
                     degree: .constant(0),
                     counter: .constant(0),
                     horizontalLineOffset: .constant(0),
                     verticalLineOffset: .constant(0),
                     lineRotationDegree: .constant(0),
                     symbols: .constant([.X, .X, .X, .X, .X, .X, .X, .X, .X,]))
    }
}
