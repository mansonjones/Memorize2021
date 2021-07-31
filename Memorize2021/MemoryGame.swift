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

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    // This is a good example of a computed property
    // where functional programming is used.
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // This is a good example of how a function can be used
    // as a functio argument. 
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards times 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: 2*pairIndex))
            cards.append(Card(content: content, id: 2*pairIndex + 1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp = true 
        var isMatched = false
        let content: CardContent
        let id: Int
    }
    
}

// A variable in an extension must be computed.

extension Array {
    var oneAndOnly: Element? {
        if self.count ==  1 {
            return first
        } else {
            return nil;
        }
    }
}
