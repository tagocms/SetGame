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
        let isSelected: Bool = false
        let isMatched: Bool = false
        
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
    private(set) var cards: [Card]
    
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
    }
}
