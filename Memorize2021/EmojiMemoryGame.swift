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

    static let emojis = [ "🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓",
                          "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍",
                          "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "⛴", "🚝" ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // The include of @Published means that
    // anytime that the model changes the
    // change is broadcast.
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>  {
        model.cards
    }
    
    // MARK: -  Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}


