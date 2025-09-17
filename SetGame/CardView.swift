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
    let fillColor: Color
    
    var body: some View {
        ZStack {
            base
            shapes
        }
    }
    
    var base: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(fillColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.black, lineWidth: 2)
            )
    }
    
    var shapes: some View {
        VStack(spacing: 8) {
            ForEach(0..<card.numberOfContent, id: \.self) { _ in
                game.getShapeWithShading(card)
                    .minimumScaleFactor(0.01)
                    .aspectRatio(2/1, contentMode: .fit)
            }
        }
        .padding(8)
    }
    
    init(_ card: SetGame<String>.Card, for game: ShapeSetGame, fillColor: Color = .white) {
        self.card = card
        self.game = game
        self.fillColor = fillColor
    }
    
}

#Preview {
    CardView(SetGame<String>.Card(id: "1/filled/red/diamond", numberOfContent: 3, shading: "striped", color: "purple", content: "diamond"), for: ShapeSetGame())
}
