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
        ZStack {
            VStack {
                cardLayout
                    .padding()
                footer
            }
            matchFeedback
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
                .transition(.slide)
        }
    }
    
    @ViewBuilder
    var footer: some View {
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
            .disabled(shapeSetGame.getCardsOnBoard.count == 30 || shapeSetGame.getCardsOnDeck.count == 0)
        }
        
        Text("Score: \(shapeSetGame.getScore)")
            .font(.headline.bold())
        Text("Cards on Deck: \(shapeSetGame.getCardsOnDeck.count)")
            .font(.caption)
    }
    
    @ViewBuilder
    var matchFeedback: some View {
        Group {
            switch shapeSetGame.matchState {
            case .common:
                EmptyView()
            case .matched:
                HStack {
                    Spacer()
                    Text("Match!!")
                    Spacer()
                }
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .padding()
                .background(.green)
                .clipShape(.rect(cornerRadius: 12))
                .padding()
                
            case .unmatched:
                HStack {
                    Spacer()
                    Text("Not a Match!!")
                    Spacer()
                }
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .padding()
                .background(.red)
                .clipShape(.rect(cornerRadius: 12))
                .padding()
            }
        }
        .transition(.scale)
    }
    
    init(_ shapeSetGame: ShapeSetGame) {
        self.shapeSetGame = shapeSetGame
    }
}

#Preview {
    ShapeSetGameView(ShapeSetGame())
}
