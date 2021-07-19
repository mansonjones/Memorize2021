//
//  Memorize2021App.swift
//  Memorize2021
//
//  Created by Manson Jones on 7/15/21.
//

import SwiftUI

@main
struct Memorize2021App: App {
    // This creates an instance of the ViewModel,
    // which is a class.
    // game is a reference to the ViewModel class
    
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
