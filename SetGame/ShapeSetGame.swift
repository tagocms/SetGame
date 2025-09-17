//
//  ShapeSetGame.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import SwiftUI

class ShapeSetGame: ObservableObject {
    enum MatchState {
        case common, matched, unmatched
    }
    
    @Published private var setGame: SetGame<String> = initializeNewGame()
    @Published var matchState: MatchState = .common
    
    // MARK: Computed properties
    var getCardsOnDeck: [SetGame<String>.Card] { setGame.cardsOnDeck }
    var getCardsOnBoard: [SetGame<String>.Card] { setGame.cardsOnBoard }
    var getSelectedCards: [Int] { setGame.selectedCardsIndices }
    var getScore: Int { setGame.score }
    
    static func initializeNewGame() -> SetGame<String> {
        return SetGame<String>(
            availableNumberOfContent: [1, 2, 3],
            availableShadings: ["solid", "striped", "open"],
            availableColors: ["red", "green", "purple"],
            availableContents: ["diamond", "squiggle", "oval"]
        )
    }
    
    private func getCardColor(_ card: SetGame<String>.Card) -> Color {
        switch card.color {
        case "red":
            return .red
        case "green":
            return .green
        case "purple":
            return .purple
        default:
            fatalError("Invalid color: \(card.color)")
        }
    }
    
    @ViewBuilder
    private func getStyle<S: Shape>(shape: S, shading: String, color: Color) -> some View {
        let stripePattern = HStack(spacing: 0) {
            ForEach(0..<21, id: \.self) { num in
                if num.isMultiple(of: 2) {
                    color
                } else {
                    Color.clear
                }
            }
        }
        
        switch shading {
        case "solid":
            shape
                .fill(color)
        case "striped":
            stripePattern
                .clipShape(shape)
                .overlay(shape.stroke(color, lineWidth: 3))
            
        case "open":
            shape
                .stroke(color, lineWidth: 3)
        default:
            shape
        }
    }
    
    @ViewBuilder
    func getShapeWithShading(_ card: SetGame<String>.Card) -> some View {
        let shading = card.shading
        let color = getCardColor(card)
        
        switch card.content {
        case "diamond":
            getStyle(shape: Diamond(), shading: shading, color: color)
        case "squiggle":
            getStyle(shape: Rectangle(), shading: shading, color: color)
        case "oval":
            getStyle(shape: Capsule(), shading: shading, color: color)
        default:
            fatalError("Invalid shape: \(card.content)")
        }
    }
    
    func getCardNumberOfShapes(_ card: SetGame<String>.Card) -> Int {
        return card.numberOfContent
    }
    
    func selectCard(_ card: SetGame<String>.Card) {
        setGame.selectCard(card)
    }
    
    func dealCards(_ number: Int) {
        setGame.dealCards(number)
    }
    
    func checkSet() {
        do {
            let setResponse = try setGame.checkSet()
            withAnimation {
                if setResponse {
                    matchState = .matched
                } else {
                    matchState = .unmatched
                }
            }
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.matchState = .common
                }
            }
        } catch {
            print("Invalid number of cards selected have been used to make a set.")
        }
    }
}
