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
        Button("Deal 3 more cards") {
            withAnimation {
                shapeSetGame.dealCards(3)
            }
        }
        ScrollView {
            cardLayout
        }
        .padding()
    }
    
    var cardLayout: some View {
        AspectVGrid(shapeSetGame.getCardsOnBoard, aspectRatio: 2/3) { card in
            CardView(card, for: shapeSetGame)
        }
    }
    
    init(_ shapeSetGame: ShapeSetGame) {
        self.shapeSetGame = shapeSetGame
    }
}

#Preview {
    ShapeSetGameView(ShapeSetGame())
}
