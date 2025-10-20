//
//  ContentView.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/19/25.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var viewModel: MontyVM
    @State private var bannerOffset: CGFloat = -300
    @State private var bannerOpacity: Double = 0.0
    @State private var bannerAsset: String? = nil
    private let columns = Array(repeating: GridItem(.flexible()), count: 5)
    private let bannerAnimDuration = 1.0

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
                    ForEach(0..<5)
                    {
                        i in Button(action: {viewModel.onCardTap(at: i)})
                        {
                            CardView(
                                imageName: viewModel.cards[i],
                                flipped: viewModel.revealed[i]
                            )
                            .offset(x: viewModel.cardOffsets.indices.contains(i) ? viewModel.cardOffsets[i] : 0)
                        }
                        .disabled(viewModel.gameOver)
                    }
                    .shadow(radius: 3)
                    .disabled(!viewModel.dealt)
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
                        Button("Play") {viewModel.newGame()}
                        .disabled(viewModel.gameStarted)
                        .font(.title)
                        .padding()
                        .foregroundColor(viewModel.dealt ? .secondary : .yellow)
                        Button("Reset") {viewModel.resetGame()}
                        .disabled(!viewModel.gameOver)
                        .foregroundColor(viewModel.gameOver ? .yellow : .secondary)
                        .font(.title)
                        .padding(50)
                    }
                    .padding(.bottom, 60)
                }
                .foregroundColor(.secondary)
            }
            .padding(.top, 100)
            .onChange(of: viewModel.gameOver)
            {
                i, isOver in if isOver
                {
                    bannerAsset = viewModel.playerWins ? "Winner" : "Loser"
                    bannerOffset = -300
                    bannerOpacity = 0
                    withAnimation(.easeInOut(duration: bannerAnimDuration))
                    {
                        bannerOffset = 0
                        bannerOpacity = 1
                    }
                }
                else
                {
                    withAnimation(.easeInOut(duration: bannerAnimDuration))
                    {
                        bannerOffset = 300
                        bannerOpacity = 0
                    }
                }
            }
            if let asset = bannerAsset
            {
                Image(asset)
                .resizable()
                .shadow(radius: 15)
                .scaledToFit()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .offset(y: bannerOffset)
                .opacity(bannerOpacity)
            }
        }
    }
}

#Preview {ContentView(viewModel: MontyVM())}
