//
//  AspectVGrid.swift
//  SetGame
//
//  Created by Tiago Camargo Maciel dos Santos on 15/09/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    let aspectRatio: CGFloat
    let content: (Item) -> ItemView
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(items) { item in
                content(item)
                    .aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
    
    init(_ items: [Item], aspectRatio: CGFloat = 1, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
}

