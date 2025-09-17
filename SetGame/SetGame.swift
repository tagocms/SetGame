//
//  SetGame.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import Foundation

struct SetGame<CardContent> where CardContent: CustomStringConvertible & Equatable {
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        enum CardState: String {
            case onDeck = "On Deck"
            case onBoard = "On Board"
            case matched = "Matched"
        }
        
        let id: String
        let numberOfContent: Int
        let shading: String
        let color: String
        let content: CardContent
        var isSelected: Bool = false
        var cardState: CardState = .onDeck
        
        var description: String {
            "Card \(id): \(numberOfContent) \(shading) \(color) \(content) -> Selected: \(isSelected), State: \(cardState)"
        }
        
        static func ==(lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    private let availableNumberOfContent: [Int]
    private let availableShadings: [String]
    private let availableColors: [String]
    private let availableContents: [CardContent]
    private(set) var cards: [Card]
    
    var cardsOnDeck: [Card] { cards.filter { $0.cardState == .onDeck } }
    var cardsOnBoard: [Card] { cards.filter { $0.cardState == .onBoard } }
    var selectedCardsIndices: [Int] { cards.indices.filter { cards[$0].cardState == .onBoard && cards[$0].isSelected } }
    
    init(availableNumberOfContent: [Int], availableShadings: [String], availableColors: [String], availableContents: [CardContent]) {
        self.availableNumberOfContent = availableNumberOfContent
        self.availableShadings = availableShadings
        self.availableColors = availableColors
        self.availableContents = availableContents
        self.cards = []
        
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
                        
                        cards.append(newCard)
                    }
                }
            }
        }
        
        self.cards.shuffle()
        
        for _ in 0..<12 {
            dealCard()
        }
    }
    
    mutating func selectCard(_ card: Card) {
        if let cardIndex = cards.firstIndex(of: card) {
            cards[cardIndex].isSelected.toggle()
            print("Card selected: \(cards[cardIndex])")
            
        }
    }
    
    mutating func dealCard() {
        let filteredIndices = cards.indices.filter { cards[$0].cardState == .onDeck }
        if let lastIndex = filteredIndices.last {
            cards[lastIndex].cardState = .onBoard
        }
    }
    
    mutating func dealCards(_ number: Int) {
        for _ in 0..<number {
            dealCard()
        }
    }
    
    // TODO: Check set logic (there is a bug in the isColorValid)
    mutating func checkSet() throws {
        if selectedCardsIndices.count == 3 {
            let indexZero = selectedCardsIndices[0]
            let indexOne = selectedCardsIndices[1]
            let indexTwo = selectedCardsIndices[2]
            
            let isContentValid = (
                (cards[indexZero].content == cards[indexOne].content)
                && (cards[indexZero].content == cards[indexTwo].content)
            ) || (
                (cards[indexZero].content != cards[indexOne].content)
                && (cards[indexZero].content != cards[indexTwo].content)
            )
            let isNumberValid = (
                (cards[indexZero].numberOfContent == cards[indexOne].numberOfContent)
                && (cards[indexZero].numberOfContent == cards[indexTwo].numberOfContent)
            ) || (
                (cards[indexZero].numberOfContent != cards[indexOne].numberOfContent)
                && (cards[indexZero].numberOfContent != cards[indexTwo].numberOfContent)
            )
            let isColorValid = (
                (cards[indexZero].color == cards[indexOne].color)
                && (cards[indexZero].color == cards[indexTwo].color)
            ) || (
                (cards[indexZero].color != cards[indexOne].color)
                && (cards[indexZero].color != cards[indexTwo].color)
            )
            let isShadingValid = (
                (cards[indexZero].shading == cards[indexOne].shading)
                && (cards[indexZero].shading == cards[indexTwo].shading)
            ) || (
                (cards[indexZero].shading != cards[indexOne].shading)
                && (cards[indexZero].shading != cards[indexTwo].shading)
            )
            
            
            if isContentValid && isNumberValid && isColorValid && isShadingValid {
                selectedCardsIndices.forEach { cards[$0].cardState = .matched }
                dealCards(3)
            }
            
            resetCardSelection()
        } else {
            throw SetGameError.invalidNumberOfCards
        }
    }
    
    mutating func resetCardSelection() {
        cards.indices.forEach { cards[$0].isSelected = false }
    }
}
