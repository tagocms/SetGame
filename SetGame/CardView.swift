//
//  CardView.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import SwiftUI

struct CardView: View {
    let card: SetGame<String>.Card
    let game: ShapeSetGame
    let cornerRadius: CGFloat = 12
    
    var body: some View {
        ZStack {
            base
            shapes
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    var base: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.white)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.black, lineWidth: 2)
            )
    }
    
    var shapes: some View {
        VStack {
            ForEach(0..<card.numberOfContent, id: \.self) { _ in
                game.getShapeWithShading(card)
                    .aspectRatio(2/1, contentMode: .fit)
                    .padding()
            }
        }
        .padding()
    }
    
    init(_ card: SetGame<String>.Card, for game: ShapeSetGame) {
        self.card = card
        self.game = game
    }
    
}

#Preview {
    CardView(SetGame<String>.Card(id: "1/filled/red/diamond", numberOfContent: 3, shading: "filled", color: "red", content: "diamond"), for: ShapeSetGame())
}
