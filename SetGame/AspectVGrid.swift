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
        GeometryReader { proxy in
            let targetWidth = gridItemWidthThatFits(count: items.count, size: proxy.size, atAspectRatio: aspectRatio)
            let gridItems = [GridItem(.adaptive(minimum: targetWidth), spacing: 0)]
            
            LazyVGrid(columns: gridItems, spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    init(_ items: [Item], aspectRatio: CGFloat = 1, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let itemCount = CGFloat(count)
        var columnCount = 1.0
        
        repeat {
            let requiredWidthForColumns = size.width / columnCount
            let requiredHeightForRows = requiredWidthForColumns / aspectRatio
            let rowCount = (itemCount / columnCount).rounded(.up)
            
            if rowCount * requiredHeightForRows < size.height {
                return requiredWidthForColumns.rounded(.down)
            }
            
            columnCount += 1
        } while columnCount < itemCount
        
        return min(size.width / itemCount, size.height * aspectRatio).rounded(.down)
    }
}

