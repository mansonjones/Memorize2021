//
//  MemoryGame.swift
//  Memorize2021
//
//  Created by Manson Jones on 7/16/21.
//

// This is the Model
// Note that it is a struct
// The model is the single source of truth.

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
       // var chosenCard = cards[chosenIndex]
        cards[chosenIndex].isFaceUp.toggle()
        // print("chosenCard = \(chosenCard)")
        // print("\(cards)")
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // fix this later
    }
    // This is a good example of how a function can be used
    // as a functio argument. 
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards times 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: 2*pairIndex))
            cards.append(Card(content: content, id: 2*pairIndex + 1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
