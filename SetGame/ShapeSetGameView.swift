//
//  ContentView.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import SwiftUI

struct ShapeSetGameView: View {
    @ObservedObject var shapeSetGame: ShapeSetGame
    
    var body: some View {
        cardLayout
            .padding()
        
        
        if shapeSetGame.getSelectedCards.count == 3 {
            Button("Check Set") {
                withAnimation {
                    shapeSetGame.checkSet()
                }
            }
        } else {
            Button("Deal 3 more cards") {
                withAnimation {
                    shapeSetGame.dealCards(3)
                }
            }
            // TODO: Clean max card on board logic
            .disabled(shapeSetGame.getCardsOnBoard.count == 24)
        }
    }
    
    var cardLayout: some View {
        AspectVGrid(shapeSetGame.getCardsOnBoard, aspectRatio: 2/3) { card in
            CardView(card, for: shapeSetGame, fillColor: card.isSelected ? .yellow : .white)
                .padding(8)
                .scaleEffect(card.isSelected ? 1.1 : 1)
                .animation(.default, value: card.isSelected)
                .onTapGesture {
                    shapeSetGame.selectCard(card)
                }
        }
    }
    
    init(_ shapeSetGame: ShapeSetGame) {
        self.shapeSetGame = shapeSetGame
    }
}

#Preview {
    ShapeSetGameView(ShapeSetGame())
}
