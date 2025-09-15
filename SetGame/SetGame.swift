//
//  SetGame.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import Foundation

struct SetGame<CardContent: CustomStringConvertible> {
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        let id: String
        let numberOfContent: Int
        let shading: String
        let color: String
        let content: CardContent
        var isSelected: Bool = false
        var isMatched: Bool = false
        
        var description: String {
            "Card \(id): \(numberOfContent) \(shading) \(color) \(content) -> Selected: \(isSelected), Matched: \(isMatched)"
        }
        
        static func ==(lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    private let availableNumberOfContent: [Int]
    private let availableShadings: [String]
    private let availableColors: [String]
    private let availableContents: [CardContent]
    private(set) var cardsOnDeck: [Card]
    private(set) var cardsOnBoard: [Card]
    
    init(availableNumberOfContent: [Int], availableShadings: [String], availableColors: [String], availableContents: [CardContent]) {
        self.availableNumberOfContent = availableNumberOfContent
        self.availableShadings = availableShadings
        self.availableColors = availableColors
        self.availableContents = availableContents
        self.cardsOnDeck = []
        self.cardsOnBoard = []
        
        for numberOfContent in availableNumberOfContent {
            for shading in availableShadings {
                for color in availableColors {
                    for content in availableContents {
                        let newCard = Card(
                            id: "\(numberOfContent)/\(shading)/\(color)/\(content)",
                            numberOfContent: numberOfContent,
                            shading: shading,
                            color: color,
                            content: content,
                        )
                        
                        cardsOnDeck.append(newCard)
                    }
                }
            }
        }
        
        self.cardsOnDeck.shuffle()
        
        for _ in 0..<12 {
            dealCard()
        }
    }
    
    mutating func selectCard(_ card: Card) {
        if let cardIndex = cardsOnDeck.firstIndex(of: card) {
            cardsOnDeck[cardIndex].isSelected = true
            print("Card selected")
        }
    }
    
    mutating func deselectCard(_ card: Card) {
        if let cardIndex = cardsOnDeck.firstIndex(of: card) {
            cardsOnDeck[cardIndex].isSelected = false
            print("Card deselected")
        }
    }
    
    mutating func dealCard() {
        if let lastCard = cardsOnDeck.popLast() {
            cardsOnBoard.append(lastCard)
        }
    }
}
