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
    
    var body: some View
    {
        ZStack
        {
            Image(imageName)
            .resizable()
            .scaledToFit()
            .opacity(flipped ? 1 : 0)
            
            Image("CardBack")
            .resizable()
            .scaledToFit()
            .opacity(flipped ? 0 : 1)
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
