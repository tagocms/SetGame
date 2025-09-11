//
//  ShapeSetGame.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import SwiftUI

class ShapeSetGame: ObservableObject {
    @Published private var setGame: SetGame<String> = initializeNewGame()
    
    // MARK: Computed properties
    var getCards: [SetGame<String>.Card] {
        return setGame.cards
    }
    
    static func initializeNewGame() -> SetGame<String> {
        return SetGame<String>(
            availableNumberOfContent: [1, 2, 3],
            availableShadings: ["solid", "striped", "open"],
            availableColors: ["red", "green", "purple"],
            availableContents: ["diamond", "squiggle", "oval"]
        )
    }
    
    func getCardColor(_ card: SetGame<String>.Card) -> Color {
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
    
    // TODO: Melhorar qual é a shape retornada
    func getCardShape(_ card: SetGame<String>.Card) -> some Shape {
        switch card.content {
        case "diamond":
            return Diamond()
        case "squiggle":
            Rectangle()
        case "oval":
            return Capsule()
        default:
            fatalError("Invalid shape: \(card.content)")
        }
    }
    
    // TODO: Fazer uma função que retorna o shading de cada carta
    
    func getCardNumberOfShapes(_ card: SetGame<String>.Card) -> Int {
        return card.numberOfContent
    }
}
