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
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            cardView(for: card)
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            //  withAnimation(.easeInOut(duration: 5)) {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Color.clear
            // Rectangle().opacity(0)
        } else  {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 3)) {
                        game.choose(card)
                    }
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
        GeometryReader { geometry in
            ZStack {
                Pie(
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 110-90)
                )
                .padding(DrawingConstants.circlePadding)
                .opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // Creating private funcs like this is a good practice.
    // It keeps the declarative code nice and clean.
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) /
            (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    
    
    private struct DrawingConstants {
        static let circlePadding: CGFloat = 5
        static let circleOpacity = 0.5
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
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

