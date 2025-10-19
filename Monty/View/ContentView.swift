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
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View
    {
        ZStack
        {
            Color(red: 21/255, green: 88/255, blue: 67/255)
            .ignoresSafeArea()
            
            VStack
            {
                LazyVGrid(columns: columns, spacing: 20)
                {
                    ForEach(0..<3)
                    {
                        i in Button(action:{viewModel.onCardTap(at: i)})
                        {
                            CardView(
                            imageName: viewModel.cards[i],
                            flipped: viewModel.revealed[i]
                            )
                            .shadow(radius: 8)

                        }
                    }
                }
                .padding()
                
                Button {viewModel.newGame()}
                label:
                {
                    Image("NewGame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 60)
                    .opacity(viewModel.gameOver ? 1 : 0)
                }
                .disabled(!viewModel.gameOver)
                .shadow(radius: 8)
            }
            
            if viewModel.gameOver
            {
                Image(viewModel.playerWins ? "Winner" : "Loser")
                .resizable()
                .shadow(radius: 8)
                .scaledToFit()
                .frame(height: 100)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.bottom, 340)}
            
        }
    }
}

#Preview {ContentView()}
