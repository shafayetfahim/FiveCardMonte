//
//  MontyVM.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/5/25.
//

import SwiftUI

class MontyVM: ObservableObject
{
    @Published var cards = ["CardAce", "CardBlank", "CardBlank", "CardBlank", "CardBlank"]
    @Published var revealed = [false, false, false, false, false]
    @Published var gameOver = false
    @Published var playerWins = false

    @Published var playerBalance = 0
    @Published var houseBalance = 0

    func onCardTap(at index: Int)
    {
        guard !gameOver else { return }

        revealed[index] = true
        playerWins = (cards[index] == "CardAce")
        gameOver = true

        if playerWins {playerBalance += 100}
        else {houseBalance += 100}
    }

    func newGame()
    {
        let acePosition = Int.random(in: cards.indices)
        cards = cards.indices.map { position in
            position == acePosition ? "CardAce" : "CardBlank"
        }
        revealed = [false, false, false, false, false]
        gameOver = false
        playerWins = false
    }
    
    func resetGame()
    {
        let acePosition = Int.random(in: cards.indices)
        cards = cards.indices.map { position in
            position == acePosition ? "CardAce" : "CardBlank"
        }

        revealed = [false, false, false, false, false]
        gameOver = false
        playerWins = false
        playerBalance = 0
        houseBalance = 0
    }
}
