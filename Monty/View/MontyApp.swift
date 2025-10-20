//
//  MontyApp.swift
//  Monty
//
//  Created by Shafayet Fahim on 10/19/25.
//

import SwiftUI

@main
struct MontyApp: App
{
    @StateObject private var viewModel = MontyVM()
    var body: some Scene
    {
        WindowGroup {ContentView(viewModel: viewModel)}
    }
}
