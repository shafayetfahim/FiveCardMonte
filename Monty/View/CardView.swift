//
//  CardView.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/19/25.
//

import SwiftUI

struct CardView: View
{
    let imageName: String
    let flipped: Bool
    @State private var rotation: Double = 0

    var body: some View
    {
        ZStack
        {
            Image("CardBack")
            .resizable()
            .scaledToFit()
            .opacity(rotation < 90 ? 1 : 0)

            Image(imageName)
            .resizable()
            .scaledToFit()
            .opacity(rotation >= 90 ? 1 : 0)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .onAppear {rotation = flipped ? 180 : 0}
        .onChange(of: flipped)
        {
            i, newValue in withAnimation(.easeInOut(duration: 0.5))
            {
                rotation = newValue ? 180 : 0
            }
        }
    }
}

#Preview
{
    ZStack
    {
        CardView(imageName: "CardAce", flipped: true)
        CardView(imageName: "CardBlank", flipped: false)
    }
}
