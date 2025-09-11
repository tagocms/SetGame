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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    init(_ shapeSetGame: ShapeSetGame) {
        self.shapeSetGame = shapeSetGame
    }
}

#Preview {
    ShapeSetGameView(ShapeSetGame())
}
