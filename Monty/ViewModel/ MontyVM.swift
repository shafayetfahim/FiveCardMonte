//
//  MontyVM.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/5/25.
//

import SwiftUI

class MontyVM: ObservableObject
{
    @Published var cards = ["CardAce", "CardBlank", "CardBlank"]
    @Published var revealed = [false, false, false]
    @Published var gameOver = false
    @Published var playerWins = false

    func onCardTap(at index: Int)
    {
        if gameOver {return}
        revealed[index] = true
        playerWins = (cards[index] == "CardAce")
        gameOver = true
    }

    func newGame()
    {
        let acePosition = Int.random(in: cards.indices)
        cards = cards.indices.map {position in position == acePosition ? "CardAce" : "CardBlank"}
        revealed = [false, false, false]
        gameOver = false
        playerWins = false
    }
}
