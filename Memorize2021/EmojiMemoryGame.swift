//
//  EmojiMemoryGame.swift
//  Memorize2021
//
//  Created by Manson Jones on 7/17/21.
//


// This is the ViewModel
// The ViewModel is a class
// The ViewModel's job is to be an intermediary
// between the model and the View
// Note the use of type variable (emojis) and a
// type function (createMemoryGame())

import SwiftUI


class EmojiMemoryGame: ObservableObject {

    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = [ "🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓",
                          "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍",
                          "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "⛴", "🚝" ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 20) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // The include of @Published means that
    // anytime that the model changes that
    // the world is notified.
    
    @Published private var model = createMemoryGame()
    
    var cards: [Card]  {
        model.cards
    }
    
    // MARK: -  Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart()  {
        model = EmojiMemoryGame.createMemoryGame()
    }
}


