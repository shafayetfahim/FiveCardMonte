//
//  MontyVM.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/19/25.
//

import SwiftUI

class MontyVM: ObservableObject
{
    @Published var cards = ["CardAce", "CardBlank", "CardBlank", "CardBlank", "CardBlank"]
    @Published var cardOffsets: [CGFloat] = Array(repeating: 0, count: 5)
    @Published var revealed = [false, false, false, false, false]
    @Published var gameStarted = false
    @Published var gameOver = false
    @Published var playerWins = false
    @Published var dealt = false
    @Published var playerBalance = 0
    @Published var houseBalance = 0

    func onCardTap(at index: Int)
    {
        guard dealt, !gameOver else {return}
        revealed[index] = true
        playerWins = (cards[index] == "CardAce")
        gameOver = true
        if playerWins {playerBalance += 100}
        else {houseBalance += 100}
    }

    func newGame()
    {
        if !gameStarted {gameStarted = true}
        let acePosition = Int.random(in: cards.indices)
        cards = cards.indices.map
        {
            position in position == acePosition ? "CardAce" : "CardBlank"
        }
        revealed = [false, false, false, false, false]
        gameOver = false
        playerWins = false
        dealt = true
        withAnimation(.easeInOut(duration: 1.0)) {cardOffsets = [0, 0, 0, 0, 0]}
    }
        
    func resetGame()
    {
        
        
        guard gameStarted else
        {
            cardOffsets = Array(repeating: 0, count: 5)
            dealt = false
            return
        }
        revealed = [false, false, false, false, false]
        gameOver = false
        playerWins = false
        dealt = false
        gameStarted = false
        withAnimation(.easeInOut(duration: 1.0)) {cardOffsets = [262, 131, 0, -131, -262]}
    }
}
