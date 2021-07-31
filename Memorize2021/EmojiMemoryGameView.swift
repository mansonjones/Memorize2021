//
//  EmojiMemoryGameView.swift
//  Memorize2021
//
//  Created by Manson Jones on 7/15/21.
//

import SwiftUI

// This is the View

struct EmojiMemoryGameView: View {
    // Reference to the ViewModel
    // The use of the ObservedObject keyword
    // means that when the viewmodel changes
    // that the body is redrawn.
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            cardView(for: card)
            
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else  {
        CardView(card: card)
            .padding(4)
            .onTapGesture {
                game.choose(card)
            }
        }
    }
}

// Views are immutable.  In the CardView, you need to
// declare isFaceUp using @State in order to modify
// it.

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 110-90)
                    )
                    .padding(DrawingConstants.circlPadding)
                    .opacity(DrawingConstants.circleOpacity)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    
    // Creating private funcs like this is a good practice.
    // It keeps the declarative code nice and clean.
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let circleOpacity: Double = 0.5
        static let circlPadding: CGFloat = 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        /*
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
 */
    }
}

