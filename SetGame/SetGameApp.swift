//
//  SetGameApp.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 11/09/25.
//

import SwiftUI

@main
struct SetGameApp: App {
    @StateObject private var shapeSetGame = ShapeSetGame()
    
    var body: some Scene {
        WindowGroup {
            ShapeSetGameView(shapeSetGame)
        }
    }
}
