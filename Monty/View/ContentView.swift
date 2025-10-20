//
//  ContentView.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/19/25.
//

import SwiftUI

struct ContentView: View
{
    @StateObject private var viewModel = MontyVM()
    let columns = Array(repeating: GridItem(.flexible()), count: 5)
    var body: some View
    {
        ZStack
        {
            Color(red: 21/255, green: 88/255, blue: 67/255)
            .ignoresSafeArea()
            VStack
            {
                LazyVGrid(columns: columns, spacing: 25)
                {
                    ForEach(0..<5)
                    {
                        i in Button(action:{viewModel.onCardTap(at: i)})
                        {
                            CardView(
                            imageName: viewModel.cards[i],
                            flipped: viewModel.revealed[i]
                            )
                            .shadow(radius: 15)
                        }
                    }
                }
                .padding(50)
                
                ZStack
                {
                    Rectangle()
                    .fill(Color.black.opacity(0.6))
                    .frame(height: 200)
                    .ignoresSafeArea()
                    .shadow(radius: 15)
                    HStack
                    {
                        VStack
                        {
                            Text("Player Balance: $\(viewModel.playerBalance)")
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                            Text("House Balance: $\(viewModel.houseBalance)")
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                        }
                        Spacer()
                        Button("Play")
                        {
                            viewModel.newGame()
                            viewModel.dealt = true
                        }
                        .disabled(viewModel.gameOver == true)
                        .font(.title)
                        .padding()
                        .foregroundColor(viewModel.gameOver ? .gray : .yellow)
                        
                        
                        Button("Reset")
                        {
                            viewModel.resetGame()
                            viewModel.dealt = false

                        }
                        .disabled(viewModel.gameOver == false)
                        .foregroundColor(viewModel.gameOver ? .yellow : .gray)
                        .font(.title)
                        .padding(50)
                    }
                    .padding(.bottom, 60)
                }
                .foregroundColor(Color.gray)
            }
            .padding(.top, 100)

            if viewModel.gameOver
            {
                Image(viewModel.playerWins ? "Winner" : "Loser")
                .resizable()
                .shadow(radius: 15)
                .scaledToFit()
                .frame(height: 200)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.bottom, 0)}
        }
    }
}

#Preview {ContentView()}
